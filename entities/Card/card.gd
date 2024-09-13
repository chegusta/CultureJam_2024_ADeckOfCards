extends Area2D

var mouse_inside : bool
var tweener : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(func(): mouse_inside = true)
	mouse_exited.connect(func(): mouse_inside = false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(1) and mouse_inside:
		global_position = get_global_mouse_position()
	if Input.is_action_just_released("mouse_click") and mouse_inside:
		EventBus.on_card_released.emit()

func snap_back_animation():
	if tweener:
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(self, "position", get_viewport_rect().size/2, 0.5).set_trans(Tween.TRANS_CUBIC) #return to center of viewport

func move_to_off_screen(final_pos : Vector2):
	if tweener:
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(self, "position", final_pos, 0.5)
	tweener.finished.connect(remove_card)

func remove_card():
	EventBus.on_card_removed.emit()
	queue_free()
