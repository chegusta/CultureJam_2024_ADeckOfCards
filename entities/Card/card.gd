extends Area2D

var mouse_inside : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(func(): mouse_inside = true)
	mouse_exited.connect(func(): mouse_inside = false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(1) and mouse_inside:
		global_position = get_global_mouse_position()
