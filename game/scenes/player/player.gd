class_name Player
extends Node2D

@onready var sprite: Sprite2D = $Sprite
var description: String = ""
var coords: Vector2i
var health: int
var turn: int
var type: PlayerData.PlayerType

func load_data(player_data: PlayerData) -> void:
	sprite.texture = player_data.sprite
	description = player_data.description
	coords = player_data.coords
	health = player_data.health
	turn = player_data.turn
	type = player_data.type

func export_data() -> PlayerData:
	var player_data: PlayerData = PlayerData.new()
	player_data.name = name
	player_data.description = description
	player_data.coords = coords
	player_data.health = health
	player_data.turn = turn
	return player_data
	
	
	
