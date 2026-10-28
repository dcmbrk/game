extends Node

@onready var _seconds: float = 1.25

func _ready() -> void:
	await get_tree().create_timer(_seconds).timeout
	get_tree().change_scene_to_file("res://scenes/main-menu/main_menu.tscn")
