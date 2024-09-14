extends Node2D

const CARD = preload("res://entities/Card/card.tscn")

const CARD_ASSETS = [preload("res://entities/Card/testing/card1.tscn"), 
preload("res://entities/Card/testing/card2.tscn"), 
preload("res://entities/Card/testing/card3.tscn"),
preload("res://entities/Card/testing/card4.tscn"),
preload("res://entities/Card/testing/card5.tscn")]

@onready var color_rect: ColorRect = $ColorRect


var original_position : Vector2
var card_stack : Array
var on_yes : bool = false
var on_no : bool = false
var choice_active : bool
var current_card



func _ready() -> void:
	##TO DO: in final version take array of cards and shuffle it before assigning Z-values OR spawn ONE card and another behind it.
	#for i in 5:
		#var c = CARD.instantiate()
		#c.global_position = get_viewport_rect().size / 2
		#add_child(c)
		#c.z_index = -i
		#c.input_pickable = false
		#card_stack.append(c)
	#
	#card_stack.shuffle()
	
	create_card_deck()
	
	original_position = get_viewport_rect().size / 2
	fetch_new_card()
	
	EventBus.on_card_released.connect(handle_released_card)
	EventBus.on_card_removed.connect(fetch_new_card)

func _on_yope_area_entered(area: Area2D) -> void:
	color_rect.color = Color.GREEN;
	on_yes = true
	choice_active = true

func _on_yope_area_exited(area: Area2D) -> void:
	color_rect.color = Color.GRAY;
	on_yes = false
	choice_active = false

func _on_nope_area_entered(area: Area2D) -> void:
	color_rect.color = Color.RED;
	on_no = true
	choice_active = true

func _on_nope_area_exited(area: Area2D) -> void:
	color_rect.color = Color.GRAY;
	on_no = false
	choice_active = false

func handle_released_card():
	if on_yes and choice_active: 
		current_card.move_to_off_screen(Vector2(2000, 690))
	elif !on_yes and !choice_active: 
		current_card.snap_back_animation()
		return
	if on_no and choice_active:
		current_card.move_to_off_screen(Vector2(-1000, 690))
	elif !on_no and !choice_active: 
		print("return to pos")
		return

func create_card_deck():
	for i in CARD_ASSETS.size():
		#instantiate assets from stack, assign screen center, make them ignore input and append to card stack array
		var c = CARD_ASSETS[i].instantiate()
		c.global_position = get_viewport_rect().size / 2
		add_child(c)
		c.input_pickable = false
		card_stack.append(c)
	
	card_stack.shuffle()
	
	#fix z-ordering of cards
	for i in card_stack.size():
		card_stack[i].z_index = -i
	

func fetch_new_card():
	if card_stack.size() < 1:
		return
	current_card = card_stack.pop_front() #take uppermost card and assigned it as the current card
	current_card.input_pickable = true #make it piackable/movable by mouse
