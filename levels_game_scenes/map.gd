extends Control

@onready var move_on: Button = $MoveOn

func _ready() -> void:
	move_on.pressed.connect(func(): SceneManager.change_scene("res://levels_game_scenes/Puzzle/puzzle_new.tscn", { "pattern": "squares", "color": Color("da3831") }))
