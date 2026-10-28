class_name RookAttackData
extends AttackData

func get_attack_cells(player_position: Vector2i, enemies_position: Array[Vector2i]) -> Array[Vector2i]:
	var attack_cells: Array[Vector2i] = []
	for i in range(5):
		if i == 0: continue
		attack_cells.append(Vector2i(player_position.x + i, player_position.y))
		attack_cells.append(Vector2i(player_position.x - i, player_position.y))
		attack_cells.append(Vector2i(player_position.x, player_position.y + i))
		attack_cells.append(Vector2i(player_position.x, player_position.y - i))
	return attack_cells.filter(is_valid_move)
