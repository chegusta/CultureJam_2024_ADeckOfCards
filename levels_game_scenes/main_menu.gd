extends Control

@onready var start_game: Button = $StartGame
@onready var deck_of_arts: Button = $DeckOfArts

func _ready() -> void:
	start_game.pressed.connect(start_main_game)
	deck_of_arts.pressed.connect(start_deck_of_arts)

func start_main_game():
	SceneManager.change_scene("res://levels_game_scenes/main.tscn", { "pattern": "squares", "color": Color("da3831") })

func start_deck_of_arts():
	SceneManager.change_scene("res://levels_game_scenes/deck_of_arts.tscn", { "pattern": "scribbles", "color": Color("da3831") })
