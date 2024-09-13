extends Control

@onready var color: ColorRect = $Color
@onready var button: Button = $Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(func(): color.color = Color(randf(), randf(), randf()))
