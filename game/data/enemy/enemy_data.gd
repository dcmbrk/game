class_name EnemyData
extends Resource

enum EnemyType { CABYBEAR, BLIGHT_MATRON, BLIGHTSTACK }

@export var sprite_coords : Vector2i 
@export var description: String = ""
@export var type: EnemyType
@export var damage: int
@export var attack: AttackData
@export var abilities: Array[PackedScene]
@export var coords: Vector2i

func get_sprite_rect() -> Rect2:
	return Rect2(
		sprite_coords.x * Game.TILE_SIZE, 
		sprite_coords.y * Game.TILE_SIZE,
		Game.TILE_SIZE, Game.TILE_SIZE
)
