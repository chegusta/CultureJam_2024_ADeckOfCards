extends Control

@onready var back_to_main: Button = $BackToMain
@onready var grid_button: Button = $GridButton
@onready var deck_view: Button = $GridView/DeckView
@onready var grid_view: TextureRect = $GridView
@onready var new_route: Button = $NewRoute

const CARD = preload("res://entities/Card/card.tscn")
const CARD_ASSETS = [preload("res://entities/DeckOfArtsCollectibles/bgirlsgo.tscn"),
	preload("res://entities/DeckOfArtsCollectibles/collectible_winduhr.tscn"), 
	preload("res://entities/DeckOfArtsCollectibles/collectible_wir_wasser.tscn")]

var original_position : Vector2
var card_stack : Array
var yes_stack : Array
var current_card

var on_yes : bool = false
var on_no : bool = false
var to_yes_stack : bool = false
var choice_active : bool

var can_go_behind : bool



func _ready() -> void:
	back_to_main.pressed.connect(return_to_main_menu)
	grid_button.pressed.connect(func(): grid_view.move_grid_view(Vector2(0, 0)))
	deck_view.pressed.connect(func(): grid_view.move_grid_view(Vector2(-750, 0)))
	new_route.pressed.connect(func(): SceneManager.change_scene("res://levels_game_scenes/LocationTEmporary.tscn", { "pattern": "curtains", "color": Color("da3831") }))

	create_card_deck()
	original_position = get_viewport_rect().size / 2
	fetch_new_card()
	
	EventBus.on_card_released.connect(handle_released_card)
	EventBus.on_card_removed.connect(fetch_new_card)


func return_to_main_menu():
	SceneManager.change_scene("res://levels_game_scenes/main_menu.tscn", { "pattern": "curtains", "color": Color("da3831") })


func _process(delta: float) -> void:
	var current_card_pos : Vector2 = current_card.global_position
	var distance_to_center:float = (current_card_pos - original_position).length()
	if distance_to_center > 200:
		can_go_behind = true
	else: can_go_behind = false
		

#func _on_yope_area_entered(area: Area2D) -> void:
	#color_rect.color = Color.GREEN;
	#on_yes = true
	#choice_active = true
#
#func _on_yope_area_exited(area: Area2D) -> void:
	#color_rect.color = Color.GRAY;
	#on_yes = false
	#choice_active = false
#
#func _on_nope_area_entered(area: Area2D) -> void:
	#color_rect.color = Color.RED;
	#on_no = true
	#choice_active = true
#
#func _on_nope_area_exited(area: Area2D) -> void:
	#color_rect.color = Color.GRAY;
	#on_no = false
	#choice_active = false

func handle_released_card():
	if can_go_behind:
		current_card.snap_back_animation()
		rearrange_cards()
	else:
		current_card.snap_back_animation()

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
	for i in card_stack.size():
		card_stack[i].z_index = -i
	current_card = card_stack.pop_front() #take uppermost card and assigned it as the current card
	current_card.input_pickable = true #make it piackable/movable by mouse

func rearrange_cards():
	card_stack.push_back(current_card)
	current_card.input_pickable = false
	for i in card_stack.size():
		card_stack[i].z_index = -i
	current_card = card_stack.pop_front() #take uppermost card and assigned it as the current card
	current_card.input_pickable = true #make it piackable/movable by mouse
