class_name Spawner
extends Node

@onready var spawn_component: SpawnComponent = $SpawnComponent
@onready var pieces: Pieces = $"../Pieces"
@onready var board: Board = $"../Board"

@onready var desk: Node2D = $"../Cards/Desk"
@onready var discard: Node2D = $"../Cards/Discard"
@onready var hand: Node2D = $"../Cards/Hand"

const ENEMY: PackedScene = preload("res://scenes/enemy/enemy.tscn")
const PLAYER: PackedScene = preload("res://scenes/player/player.tscn")
const DESK: PackedScene = preload("res://scenes/desk/desk.tscn")
const HAND: PackedScene = preload("res://scenes/hand/hand.tscn")

func init_desk(desk_data) -> Desk:
	var desk_instance: Desk = spawn_component.spawn_instance(
			DESK, 
			desk
		)
	desk_instance.load_data(Game.current_desk)
	desk_instance.setup()
	return desk_instance

func init_discard(desk_data) -> Desk:
	var discard_instance: Desk = spawn_component.spawn_instance(
		DESK, 
		discard
	)
	discard_instance.load_data(Game.current_discard)
	discard_instance.setup()
	return discard_instance

func init_enemy(enemy_data: EnemyData) -> Enemy:
	var enemy: Enemy = spawn_component.spawn_instance(
		ENEMY, 
		pieces
	)
	enemy.load_data(enemy_data)
	return enemy
	
func init_enemies(enemies_data: Array[EnemyData]) -> Array[Enemy]:
	var enemies: Array[Enemy]
	for enemy_data: EnemyData in enemies_data:
		var enemy: Enemy = init_enemy(enemy_data)
		enemies.append(enemy)
		pieces.move(enemy, enemy.coords)
	return enemies
	
func init_player(player_data: PlayerData) -> Player:
	var player: Player = spawn_component.spawn_instance(PLAYER, pieces)
	player.load_data(player_data)
	pieces.move(player, player.coords)
	return player

func init_hand(desk_data: DeskData) -> Hand:
	var hand_instance: Hand = spawn_component.spawn_instance(HAND, hand)
	hand_instance.load_data(desk_data)
	hand_instance.setup()
	return hand_instance
