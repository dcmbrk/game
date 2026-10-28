extends Node

@onready var _seconds: float = 1.25
@onready var transition_label: Label = $TransitionLabel

func _ready() -> void:
	transition_label.text = "Level %s / %s" % [
			str(Game.current_level.level), 
			str(Game.current_map.levels.size())
	]
	await get_tree().create_timer(_seconds).timeout
	get_tree().change_scene_to_file("res://scenes/level/level.tscn")
