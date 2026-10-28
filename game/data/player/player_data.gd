class_name PlayerData
extends Resource

enum PlayerType { PAWNBARIAN, KNIGHTEMPLAR }

@export var type: PlayerType
@export var description: String = ""
@export var coords: Vector2i = Vector2(2, 4)
@export var health: int = 3
@export var turn: int = 2
@export var sprite: CompressedTexture2D

func get_type_name() -> String:
	var names: Dictionary = {
		PlayerType.PAWNBARIAN: "Pawnbarian",
		PlayerType.KNIGHTEMPLAR: "Knight Templar"
	}
	return names[type]
