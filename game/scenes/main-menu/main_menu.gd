extends Node

@onready var continue_button: Button = $Buttons/Continue
@onready var new_game_button: Button = $Buttons/NewGame

func _ready() -> void:
	if Game.current_map == null:
		continue_button.disabled = true

	new_game_button.button_down.connect(_on_new_game_button_down)
	
func _on_new_game_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/player_select/select_player.tscn")
