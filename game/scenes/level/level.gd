extends Node

const DRAW_CAR_PER_TURN: int = 3

@onready var scener: Node = $Scener
@onready var pieces: Pieces = $Pieces
@onready var cards_controller: Cards = $Cards
@onready var board: Board = $Board

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			if not cards_controller.is_selecting_card():  return
				
			var cell: Vector2i = board.get_cell_coordinates_from_mouse_position()
			var select_cells: Array[Vector2i] = cards_controller.selected_attack_data.get_attack_cells(
					pieces.get_player_position(), 
					pieces.get_enemies_position())

			if cell in select_cells:
				cards_controller.play_card()
				pieces.move_player(cell)
				board.clear_selects(select_cells)
					
			if pieces.player_instance.is_out_of_energy():
				cards_controller.draw_cards()
