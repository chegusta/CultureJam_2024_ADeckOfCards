extends Node2D

const CARD = preload("res://card.tscn")

@onready var color_rect: ColorRect = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 3:
		var c = CARD.instantiate()
		c.global_position = get_viewport_rect().size / 2
		c.global_position.x -= 32 * i
		add_child(c)
		c.z_index = -i
		if i > 0:
			c.input_pickable = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_yope_area_entered(area: Area2D) -> void:
	color_rect.color = Color.GREEN;

func _on_yope_area_exited(area: Area2D) -> void:
	color_rect.color = Color.GRAY;

func _on_nope_area_exited(area: Area2D) -> void:
	color_rect.color = Color.GRAY;

func _on_nope_area_entered(area: Area2D) -> void:
	color_rect.color = Color.RED;
