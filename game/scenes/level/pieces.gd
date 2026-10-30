class_name Pieces
extends Node

@onready var board: Board = $"../Board"
@onready var spawner: Spawner = $"../Spawner"

@onready var player_data: PlayerData = Game.current_player
@onready var player_instance: Player
@onready var enemies_data: Array[EnemyData]	= Game.current_enemies
@onready var enemies_instance: Array[Enemy]

func _ready() -> void:
	enemies_instance = spawner.init_enemies(enemies_data) as Array[Enemy]
	player_instance = spawner.init_player(player_data) as Player

func _init_level() -> void:
	enemies_instance = spawner.init_enemies(enemies_data) as Array[Enemy]
	player_instance = spawner.init_player(player_data) as Player

func move(piece: Node2D, coords: Vector2i) -> void:
	var position: Vector2 = board.get_global_position_from_cell(coords)
	piece.position = position
	piece.coords = coords
	
func move_player(coords: Vector2) -> void:
	move(self.player_instance, coords)
	
func get_player_position() -> Vector2i:
	return player_instance.coords
	
func get_enemies_position() -> Array[Vector2i]:
	var enemies_position: Array[Vector2i]
	for enemy_instance in enemies_instance:
		enemies_position.append(enemy_instance.coords)
	return enemies_position
