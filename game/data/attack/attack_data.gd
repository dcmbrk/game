class_name AttackData
extends Resource

@export var name: String = ""

func is_valid_move(cell: Vector2i) -> bool:
	return cell.x <= 4 and cell.x >= 0 and cell.y <= 4 and cell.y >= 0
