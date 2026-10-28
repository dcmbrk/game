extends Node

const DRAW_CAR_PER_TURN: int = 3

@onready var spawner: Node = $Spawner
@onready var scener: Node = $Scener
@onready var desk: Node = $Desk
@onready var board: Board = $Board

@onready var enemies_data: Array[EnemyData]	= Game.current_enemies
@onready var player_data: PlayerData = Game.current_player
@onready var desk_data: DeskData = Game.current_desk
@onready var discard_data: DeskData = Game.current_discard
@onready var hand_data: DeskData = Game.current_hand

@onready var enemies_instance: Array[Enemy]
@onready var player_instance: Player
@onready var desk_instance: Desk
@onready var discard_instance: Desk
@onready var hand_instance: Hand

@onready var player_position: Vector2i
@onready var enemies_position: Array[Vector2i] = []

@onready var selected_attack_data: AttackData
@onready var selected_card: BigCard

func _ready() -> void:
	_init_level()

func _init_level() -> void:
	
	enemies_instance = spawner.init_enemies(enemies_data) as Array[Enemy]
	player_instance = spawner.init_player(player_data) as Player
	desk_instance = spawner.init_desk(desk_data) as Desk
	discard_instance = spawner.init_discard(discard_data) as Desk
	hand_instance = spawner.init_hand(hand_data) as Hand
	
	setup_instances_position()
	draw_cards()

func setup_instances_position() -> void:
	player_position = player_instance.coords
	for enemy_instance in enemies_instance:
		enemies_position.append(enemy_instance.coords)
		
func connect_hand() -> void:
	for child: BigCard in hand_instance.get_children():
		child.click_in.connect(_on_big_card_click_in)
		child.click_out.connect(_on_big_card_click_out)
		child.hover_in.connect(_on_big_card_hover_in)
		child.hover_out.connect(_on_big_card_hover_out)

func _on_big_card_click_in(card_instance: BigCard) -> void:
	if selected_card:
		selected_card.hand_down()
	selected_card = card_instance
	selected_card.hand_up()
	clear_attack_select(selected_attack_data)
	selected_attack_data = card_instance.attack
	show_attack_select(selected_attack_data)

func _on_big_card_click_out(card_instance: BigCard) -> void:
	selected_card.hand_down()
	selected_card = null
	clear_attack_select(selected_attack_data)
	
func _on_big_card_hover_in(card_instance: BigCard) -> void:
	clear_attack_highlight(selected_attack_data)
	selected_attack_data = card_instance.attack
	show_attack_highlight(selected_attack_data)
	
func _on_big_card_hover_out(card_instance: BigCard) -> void:
	clear_attack_highlight(selected_attack_data)
	
func clear_attack_highlight(attack_data: AttackData) -> void:
	if not attack_data: return
	var highlight_cells: Array[Vector2i] = attack_data.get_attack_cells(player_position, enemies_position)
	board.clear_highlights(highlight_cells)

func show_attack_highlight(attack_data: AttackData) -> void:
	if not attack_data: return
	var highlight_cells: Array[Vector2i] = attack_data.get_attack_cells(player_position, enemies_position)
	board.show_hightlights(highlight_cells)
	
func show_attack_select(attack_data: AttackData) -> void:
	if not attack_data: return
	var select_cells: Array[Vector2i] = attack_data.get_attack_cells(player_position, enemies_position)
	board.show_selects(select_cells)

func clear_attack_select(attack_data: AttackData) -> void:
	if not attack_data: return
	var select_cells: Array[Vector2i] = attack_data.get_attack_cells(player_position, enemies_position)
	board.clear_selects(select_cells)

func _on_skip_turn_button_button_down() -> void:
	if desk_data.cards.is_empty():
		discard_data.move_all_cards(desk_data)
	
	hand_data.move_all_cards(discard_data)
	desk_data.move_random_cards(hand_data, DRAW_CAR_PER_TURN)
	
	desk_instance.setup()
	discard_instance.setup()
	hand_instance.setup()
	
	connect_hand()

func draw_cards() -> void:
	desk_data.move_random_cards(hand_data, DRAW_CAR_PER_TURN)
	desk_instance.setup()
	discard_instance.setup()
	hand_instance.setup()
	connect_hand()

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
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT:
				if not selected_card: return
				var cell: Vector2i = board.get_cell_coordinates_from_mouse_position()
				var select_cells: Array[Vector2i] =  selected_attack_data.get_attack_cells(player_position, enemies_position)
				if cell in select_cells:
					player_instance.coords = cell
					player_instance.position = board.get_global_position_from_cell(player_instance.coords) - Vector2(0, Game.TILE_SIZE_QUARTER)
					clear_attack_select(selected_card.attack)
					var selected_card_data = selected_card.export_data()
					discard_data.cards.append(selected_attack_data)
					selected_card.queue_free()
					hand_instance.remove_child(selected_card)
					setup_instances_position()
				if hand_instance.get_children().is_empty():
						hand_data.cards.clear()
						draw_cards()
