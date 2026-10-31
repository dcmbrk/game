class_name Turns
extends HBoxContainer

const TURN: PackedScene = preload("res://scenes/turns/turn.tscn")
const START_TURNS: int = 2

@onready var pieces: Pieces = $"../../../Pieces"

func _ready() -> void:
	render_turns(START_TURNS)

	if pieces.player_instance:
		pieces.player_instance.enery_changed.connect(_on_player_energy_changed)

func _clear() -> void:
	for child in get_children():
		remove_child(child)

func _add_turns(turn_numbers: int) -> void:
	for i in range(turn_numbers):
		var turn_instance: Turn = TURN.instantiate()
		add_child(turn_instance)

func render_turns(turn_numbers: int) -> void:
	self._clear()
	self._add_turns(turn_numbers)

func _on_player_energy_changed(current_energy: int) -> void:
	self.render_turns(current_energy)
