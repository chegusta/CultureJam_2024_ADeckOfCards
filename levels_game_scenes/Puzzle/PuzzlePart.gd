extends Area2D

@export var target : Node2D

var mouse_inside : bool
var tweener : Tween
var is_held : bool
var locked : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(func(): mouse_inside = true)
	mouse_exited.connect(func(): mouse_inside = false)
	EventBus.on_piece_held.connect(handle_held)
	EventBus.on_card_released.connect(handle_release)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(1) and mouse_inside:
		is_held = true
		EventBus.on_piece_held.emit()
	if Input.is_action_just_released("mouse_click") and mouse_inside:
		is_held = false
		EventBus.on_card_released.emit()
	
	if is_held:
		global_position = get_global_mouse_position()

func handle_held():
	# am I the piece being held? if yes...
	if !is_held: input_pickable = false #otherwise can't be picked up

func handle_release():
	if !locked:
		input_pickable = true
	
	##check distance to target
	var dist_to_target : float = (target.global_position - global_position).length()
	if dist_to_target < 100:
		snap_to_target()
		locked = true

func snap_to_target():
	if tweener:
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(self, "position", target.global_position, 0.5).set_trans(Tween.TRANS_CUBIC) #return to center of viewport
	tweener.finished.connect(func(): EventBus.on_puzzle_progressed.emit())
