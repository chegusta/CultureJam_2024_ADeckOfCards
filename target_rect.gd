extends TextureRect

# Reference to the correct piece that should be dropped here
@export var correct_piece: TextureRect


func _get_drag_data(at_position):
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
	if correct_piece and correct_piece.get_global_rect().has_point(get_global_mouse_position()):
		texture = data  # Set the texture
		position = correct_piece.position  # Snap it to the target's position
		set_drag_preview(null)  # Remove the drag preview since it’s placed
		set_process_input(false)  # Disable further dragging for this piece
	else:
		# If dropped in the wrong place, return the texture to the piece
		texture = data
