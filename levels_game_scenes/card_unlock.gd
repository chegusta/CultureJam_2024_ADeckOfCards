extends Control

@onready var main_menu: Button = $MainMenu
@onready var new_route: Button = $NewRoute
@onready var grid: Button = $Grid

func _ready() -> void:
	main_menu.pressed.connect(func(): SceneManager.change_scene("res://levels_game_scenes/main_menu.tscn", { "pattern": "curtains", "color": Color("da3831") }))
	new_route.pressed.connect(func(): SceneManager.change_scene("res://levels_game_scenes/LocationTEmporary.tscn", { "pattern": "curtains", "color": Color("da3831") }))
	grid.pressed.connect(func(): SceneManager.change_scene("res://levels_game_scenes/deck_of_arts.tscn", { "pattern": "curtains", "color": Color("da3831") }))
