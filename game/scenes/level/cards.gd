class_name Cards
extends Node

const DRAW_CAR_PER_TURN: int = 3

@onready var spawner: Spawner = $"../Spawner"
@onready var board: Board = $"../Board"
@onready var pieces: Pieces = $"../Pieces"

@onready var desk_instance: Desk
@onready var discard_instance: Desk
@onready var hand_instance: Hand

@onready var selected_attack_data: AttackData
@onready var selected_card: BigCard

func _ready() -> void:
	desk_instance = spawner.init_desk(Game.current_desk) as Desk
	discard_instance = spawner.init_discard(Game.current_discard) as Desk
	hand_instance = spawner.init_hand(Game.current_hand) as Hand
	
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
					
func draw_cards() -> void:
	hand_instance.desk_data.move_all_cards(discard_instance.desk_data)
	
	if desk_instance.desk_data.cards.size() < DRAW_CAR_PER_TURN:
		discard_instance.desk_data.move_all_cards(desk_instance.desk_data)
		
	desk_instance.desk_data.move_random_cards(hand_instance.desk_data, DRAW_CAR_PER_TURN)
	pieces.player_instance.reset_energy()
	
	setup_cards()


func _on_skip_turn_button_button_up() -> void:
	draw_cards()
	
func setup_cards() -> void:
	desk_instance.setup()
	discard_instance.setup()
	hand_instance.setup()
	connect_hand()
	
func play_card() -> void:
	hand_instance.desk_data.cards.erase(selected_card.card_data)
	discard_instance.desk_data.cards.append(selected_card.card_data)
	selected_card = null
	selected_attack_data = null
	setup_cards()
	pieces.player_instance.decrease_energy()
	
func is_selecting_card() -> bool:
	return self.selected_card or self.selected_attack_data
