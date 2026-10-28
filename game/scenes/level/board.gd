class_name Board
extends Node

@onready var units: TileMapLayer = $Units
@onready var highlights: TileMapLayer = $Highlights

func get_cell_coordinates_from_mouse_position() -> Vector2i:
	var local_mouse_position := units.get_local_mouse_position()
	var cell_coords: Vector2i = units.local_to_map(local_mouse_position)
	return cell_coords
	
func get_global_position_from_cell(cell_position: Vector2i) -> Vector2:
	var local_position: Vector2 = units.map_to_local(cell_position)
	var global_position: Vector2 = units.to_global(local_position)
	return global_position

func show_highlight(cell: Vector2i) -> void:
	highlights.set_cell(cell, 0, Vector2i(0, 1))

func clear_highlight(cell: Vector2i) -> void:
	highlights.erase_cell(cell)

func show_hightlights(cells: Array[Vector2i]) -> void:
	if not cells:
		return
		
	for cell in cells:
		show_highlight(cell)

func clear_highlights(cells: Array[Vector2i]) -> void:
	if not cells:
		return
	
	for cell in cells:
		clear_highlight(cell)
		
func show_select(cell: Vector2i) -> void:
	highlights.set_cell(cell, 0, Vector2i(1, 1))
	
func show_selects(cells: Array[Vector2i]) -> void:
	if not cells:
		return
	
	for cell in cells:
		show_select(cell)

func clear_select(cell: Vector2i) -> void:
	highlights.erase_cell(cell)

func clear_selects(cells: Array[Vector2i]) -> void:
	if not cells:
		return
		
	for cell in cells:
		clear_select(cell)
