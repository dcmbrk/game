extends Node

const DRAW_CAR_PER_TURN: int = 3

@onready var scener: Node = $Scener
@onready var desk: Node = $Desk
@onready var board: Board = $Board
@onready var pieces: Pieces = $Pieces
@onready var spawner: Spawner = $Spawner

@onready var desk_data: DeskData = Game.current_desk
@onready var discard_data: DeskData = Game.current_discard
@onready var hand_data: DeskData = Game.current_hand

@onready var desk_instance: Desk
@onready var discard_instance: Desk
@onready var hand_instance: Hand

@onready var selected_attack_data: AttackData
@onready var selected_card: BigCard

var energy = 2

func _ready() -> void:
	_init_level()

func _init_level() -> void:
	desk_instance = spawner.init_desk(desk_data) as Desk
	discard_instance = spawner.init_discard(discard_data) as Desk
	hand_instance = spawner.init_hand(hand_data) as Hand
	
	draw_cards()
	
	
func connect_hand() -> void:
	for child: BigCard in hand_instance.get_children():
		if child.click_in.is_connected(_on_big_card_click_in) == false:
			child.click_in.connect(_on_big_card_click_in)
		if child.click_out.is_connected(_on_big_card_click_out) == false:
			child.click_out.connect(_on_big_card_click_out)
		if child.hover_in.is_connected(_on_big_card_hover_in) == false:
			child.hover_in.connect(_on_big_card_hover_in)
		if child.hover_out.is_connected(_on_big_card_hover_out) == false:
			child.hover_out.connect(_on_big_card_hover_out)

func _on_big_card_click_in(card_instance: BigCard) -> void:
	if selected_card:
		selected_card.hand_down()
		if selected_attack_data:
			board.clear_selects(
				selected_attack_data.get_attack_cells(
					pieces.get_player_position(), 
					pieces.get_enemies_position()))
			
	selected_card = card_instance
	selected_card.hand_up()
	
	selected_attack_data = card_instance.card_data.attack
	if selected_attack_data:
		board.show_selects(
				selected_attack_data.get_attack_cells(
					pieces.get_player_position(), 
					pieces.get_enemies_position()))

func _on_big_card_click_out(card_instance: BigCard) -> void:
	if selected_card:
		selected_card.hand_down()
	if selected_attack_data:
		board.clear_selects(
				selected_attack_data.get_attack_cells(
					pieces.get_player_position(), 
					pieces.get_enemies_position()))
	selected_card = null
	selected_attack_data = null
	
func _on_big_card_hover_in(card_instance: BigCard) -> void:
	if card_instance != selected_card and card_instance.card_data.attack:
		board.show_hightlights(card_instance.card_data.attack.get_attack_cells(
					pieces.get_player_position(), 
					pieces.get_enemies_position()))
	
func _on_big_card_hover_out(card_instance: BigCard) -> void:
	if card_instance != selected_card and card_instance.card_data.attack:
		board.clear_highlights(card_instance.card_data.attack.get_attack_cells(
					pieces.get_player_position(), 
					pieces.get_enemies_position()))

func _on_skip_turn_button_button_down() -> void:
	draw_cards()

func draw_cards() -> void:
	hand_data.move_all_cards(discard_data)
	
	if desk_data.cards.size() < DRAW_CAR_PER_TURN:
		discard_data.move_all_cards(desk_data)
		
	desk_data.move_random_cards(hand_data, DRAW_CAR_PER_TURN)
	
	desk_instance.setup()
	discard_instance.setup()
	hand_instance.setup()
	connect_hand()
	energy = 2

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_SPACE:
			var next_level: LevelData = Game.current_map.get_next_level()
			if next_level:
				scener.change_next_level()
			else:
				scener.change_winning_message()
		if event.is_pressed() and event.keycode == KEY_ESCAPE:
			scener.change_menu()
			
	elif event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			if not selected_card or not selected_attack_data: 
				return
				
			var cell: Vector2i = board.get_cell_coordinates_from_mouse_position()
			var select_cells: Array[Vector2i] = selected_attack_data.get_attack_cells(
					pieces.get_player_position(), 
					pieces.get_enemies_position())

			if cell in select_cells:
				pieces.move_player(cell)
				board.clear_selects(select_cells)
				
				var card_data: CardData = selected_card.card_data
				if card_data:
					hand_data.cards.erase(card_data)
					discard_data.cards.append(card_data)
				
				selected_card.queue_free()
				selected_card = null
				selected_attack_data = null
				
				discard_instance.setup()
				
				energy -= 1
				
				
				print("Desk: %d" % desk_data.cards.size())
				print("Discard: %d" % discard_data.cards.size())
				print("Hand: %d" % hand_data.cards.size())
				
			if energy == 0:
				draw_cards()
