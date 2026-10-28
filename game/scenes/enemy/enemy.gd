class_name Enemy
extends Node2D

@onready var sprite: Sprite2D = $Sprite
var description: String = ""
var type: EnemyData.EnemyType
var damage: int
var attack: AttackData
var abilities: Array[PackedScene]
var coords: Vector2
	
func load_data(enemy_data: EnemyData) -> void:
	sprite.region_rect = enemy_data.get_sprite_rect()
	description = enemy_data.description
	type = enemy_data.type
	damage = enemy_data.damage
	attack = enemy_data.attack
	abilities = enemy_data.abilities
	coords = enemy_data.coords
	
func export_data() -> EnemyData:
	var enemy_data = EnemyData.new()
	enemy_data.sprite = sprite.texture
	enemy_data.description = description
	enemy_data.type = type
	enemy_data.damage = damage
	enemy_data.attack = attack
	enemy_data.abilities = abilities
	enemy_data.coords = coords
	return enemy_data
