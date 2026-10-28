class_name Spawner
extends Node

@onready var spawn_component: SpawnComponent = $SpawnComponent
@onready var desk: Node = $"../Desk"
@onready var discard: Node = $"../Discard"
@onready var pieces: Node = $"../Pieces"
@onready var board: Board = $"../Board"
@onready var hand: Node = $"../Hand"

const ENEMY: PackedScene = preload("res://scenes/enemy/enemy.tscn")
const PLAYER: PackedScene = preload("res://scenes/player/player.tscn")
const DESK: PackedScene = preload("res://scenes/desk/desk.tscn")
const HAND: PackedScene = preload("res://scenes/hand/hand.tscn")

func init_desk(desk_data) -> Desk:
	var desk_spawn_position: Vector2 = Vector2(64, 125)
	var desk_instance: Desk = spawn_component.spawn_instance(
			DESK, 
			desk_spawn_position,
			desk
		)
	desk_instance.load_data(Game.current_desk)
	desk_instance.setup()
	return desk_instance

func init_discard(desk_data) -> Desk:
	var discard_spawn_position: Vector2 = Vector2(64, 320) 
	var discard_instance: Desk = spawn_component.spawn_instance(
		DESK, 
		discard_spawn_position,
		desk
	)
	discard_instance.load_data(Game.current_discard)
	discard_instance.setup()
	return discard_instance

func init_enemy(enemy_data: EnemyData) -> Enemy:
	var enemy_spawn_position: Vector2 = board.get_global_position_from_cell(enemy_data.coords)
	var enemy: Enemy = spawn_component.spawn_instance(
		ENEMY, 
		enemy_spawn_position,
		pieces
	)
	enemy.load_data(enemy_data)
	return enemy
	
func init_enemies(enemies_data: Array[EnemyData]) -> Array[Enemy]:
	var enemies: Array[Enemy]
	for enemy_data: EnemyData in enemies_data:
		var enemy: Enemy = init_enemy(enemy_data)
		enemies.append(enemy)
	return enemies
	
func init_player(player_data: PlayerData) -> Player:
	var player_spawn_position: Vector2 = board.get_global_position_from_cell(player_data.coords) - Vector2(0, Game.TILE_SIZE_QUARTER)
	var player: Player = spawn_component.spawn_instance(PLAYER, player_spawn_position, pieces)
	player.load_data(player_data)
	return player

func init_hand(desk_data: DeskData) -> Hand:
	var hand_spawn_position: Vector2 = Vector2(370, 500)
	var hand_instance: Hand = spawn_component.spawn_instance(HAND, hand_spawn_position, hand)
	hand_instance.load_data(desk_data)
	hand_instance.setup()
	return hand_instance
	
