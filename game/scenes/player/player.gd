class_name Player
extends Node2D

const START_HP = 2
const START_ENERGY = 2
const START_SHIELD = 0

signal enery_changed(current_energy: int)
signal health_changed(current_hp: int, current_shield: int)

@onready var sprite: Sprite2D = $Sprite
var description: String = ""
var coords: Vector2i
var health: int
var turn: int
var type: PlayerData.PlayerType
var shield = START_SHIELD
var energy = START_ENERGY

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
	
func decrease_energy() -> void:
	self.energy -= 1
	enery_changed.emit(self.energy)

func increase_energy() -> void:
	self.energy += 1
	enery_changed.emit(self.energy)

func reset_energy() -> void:
	self.energy = START_ENERGY
	enery_changed.emit(self.energy)
	
func is_out_of_energy() -> bool:
	return self.energy == 0
	
func decrease_shield() -> void:
	self.shield -= 1
	health_changed.emit(self.health, self.shield)

func increase_shield() -> void:
	self.shield += 1
	health_changed.emit(self.health, self.shield)

func reset_shield() -> void:
	self.shield = START_SHIELD
	health_changed.emit(self.health, self.shield)
	
func is_out_of_shield() -> bool:
	return self.shield == 0
	
func decrease_hp() -> void:
	self.health -= 1
	health_changed.emit(self.health, self.shield)

func increase_hp() -> void:
	self.health += 1
	health_changed.emit(self.health, self.shield)

func reset_hp() -> void:
	self.health = START_HP
	health_changed.emit(self.health, self.shield)
	
func is_out_of_hp() -> bool:
	return self.health == 0
