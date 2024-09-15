extends TextureRect

var tweener: Tween

@onready var go_to_card: Button = $GoToCard

func _ready() -> void:
	go_to_card.pressed.connect(func(): SceneManager.change_scene("res://levels_game_scenes/card_unlock.tscn", { "pattern": "curtains", "color": Color("da3831") }))

func move_grid_view(final_position):
	if tweener:
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(self, "position", final_position, 0.5).set_trans(Tween.TRANS_CUBIC) #return to center of viewport
