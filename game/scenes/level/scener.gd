extends Node

func change_next_level() -> void:
	Game.current_level = Game.current_map.change_next_level()
	get_tree().change_scene_to_file("res://scenes/transition/transition.tscn")

func change_winning_message() -> void:
	Game.reset()
	get_tree().change_scene_to_file("res://scenes/winning_message/winning_message.tscn")
	
func change_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/main-menu/main_menu.tscn")
