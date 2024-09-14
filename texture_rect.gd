extends TextureRect

# This will hold a reference to the correct target TextureRect
@export var correct_target: TextureRect

var is_locked = false  # Used to track if the piece is already in its place

func _ready():
	# You can initialize additional properties here if necessary
	pass

func _get_drag_data(at_position):
	if is_locked:
		return null  # If the piece is already placed, don't drag it again

	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(350, 350)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	texture = null
	
	return preview_texture.texture

func _can_drop_data(_pos, data):
	return data is Texture2D

func _drop_data(_pos, data):
	# Check if we are dropping onto the correct target
	if correct_target and correct_target.get_global_rect().has_point(get_global_mouse_position()):
		texture = data  # Set the texture
		position = correct_target.position  # Snap to target's position
		set_process_input(false)  # Disable further dragging
		is_locked = true  # Mark as placed
	else:
		# If dropped elsewhere, return the texture to the piece
		texture = data
