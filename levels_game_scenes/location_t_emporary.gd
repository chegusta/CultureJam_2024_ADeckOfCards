extends Control

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(func(): SceneManager.change_scene("res://levels_game_scenes/main.tscn",  { "pattern": "squares", "color": Color("da3831") }))
