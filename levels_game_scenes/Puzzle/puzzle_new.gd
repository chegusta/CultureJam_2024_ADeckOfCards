extends Control

@onready var target_1: Node2D = $"B-girls,Go!V1/Target1"
@onready var target_2: Node2D = $"B-girls,Go!V1/Target2"
@onready var target_3: Node2D = $"B-girls,Go!V1/Target3"
@onready var target_4: Node2D = $"B-girls,Go!V1/Target4"

@onready var card: Area2D = $Card
@onready var card_2: Area2D = $Card2
@onready var card_4: Area2D = $Card4
@onready var card_3: Area2D = $Card3

var can_transition : bool = true

func _ready() -> void:
	EventBus.on_puzzle_progressed.connect(check_puzzle_solution)
	
func check_puzzle_solution():
	if card.global_position == target_1.global_position and card_2.global_position == target_2.global_position and card_3.global_position == target_3.global_position and card_4.global_position == target_4.global_position and can_transition:
		can_transition = false
		SceneManager.change_scene("res://levels_game_scenes/card_unlock.tscn", { "pattern": "curtains", "color": Color("da3831") })
