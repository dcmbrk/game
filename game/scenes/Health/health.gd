class_name Health
extends HBoxContainer

const HP: PackedScene = preload("res://scenes/Health/hp.tscn")
const SHIELD: PackedScene = preload("res://scenes/Health/shield.tscn")

@onready var pieces: Pieces = $"../../../Pieces"

func _ready() -> void:

	if pieces.player_instance:
		pieces.player_instance.health_changed.connect(_on_player_energy_changed)

	render_health(pieces.player_instance.health, pieces.player_instance.shield)


func _clear() -> void:
	for child in get_children():
		remove_child(child)

func _add_hp(hp_numbers: int) -> void:
	for i in range(hp_numbers):
		var hp_instance: HP = HP.instantiate()
		add_child(hp_instance)

func _add_shield(shield_numbers: int) -> void:
	for i in range(shield_numbers):
		var shield_instance: Shield = SHIELD.instantiate()
		add_child(shield_instance)

func render_health(hp_numbers: int, shield_numbers: int) -> void:
	self._clear()
	self._add_hp(hp_numbers)
	self._add_shield(shield_numbers)

func _on_player_energy_changed(current_hp, current_shield) -> void:
	render_health(current_hp, current_shield)
