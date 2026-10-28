class_name KnightAttackData
extends AttackData
	
func get_attack_cells(player_position: Vector2i, enemies_position: Array[Vector2i]) -> Array[Vector2i]:
	var attack_cells: Array[Vector2i] = []
	attack_cells.append(Vector2i(player_position.x - 1, player_position.y + 2))
	attack_cells.append(Vector2i(player_position.x + 1, player_position.y + 2))
	attack_cells.append(Vector2i(player_position.x - 2, player_position.y + 1))
	attack_cells.append(Vector2i(player_position.x + 2, player_position.y + 1))
	attack_cells.append(Vector2i(player_position.x - 2, player_position.y - 1))
	attack_cells.append(Vector2i(player_position.x + 2, player_position.y - 1))
	attack_cells.append(Vector2i(player_position.x - 1, player_position.y - 2))
	attack_cells.append(Vector2i(player_position.x + 1, player_position.y - 2))
	return attack_cells.filter(is_valid_move)
