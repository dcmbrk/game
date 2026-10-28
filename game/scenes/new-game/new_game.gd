extends Node

## Nodes
@onready var right_arrow: Button = $Arrows/RightArrow
@onready var left_arrow: Button = $Arrows/LeftArrow
@onready var map: TextureRect = $Map/Map
@onready var title: Label = $Map/Title
@onready var description: Label = $Map/Description
@onready var embark: Button = $Buttons/Embark
@onready var back: Button = $Buttons/Back

# Data
@export var maps: Array[MapData]

## Know
var index: int = 0
@onready var size: int = maps.size()

func _ready() -> void:
	right_arrow.button_down.connect(_on_right_arrow_button_down)
	left_arrow.button_down.connect(_on_left_arrow_button_down)
	embark.button_down.connect(_on_embark_button_down)
	back.button_down.connect(_on_back_button_down)
	
	_render_map()
	
func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/player_select/select_player.tscn")
	

	
func _on_right_arrow_button_down():
	index += 1
	_render_map()
	
func _on_left_arrow_button_down():
	index -= 1
	_render_map()
	
func _render_map() -> void:
	var current_map: MapData = maps[index % size]
	map.texture = load(current_map.image.load_path)
	title.text = current_map.title
	description.text = current_map.description

func _on_embark_button_down():
	_init_game()
	
func _init_game():
	var current_map: MapData = maps[index % size]
	Game.current_map = current_map
	Game.current_level = current_map.get_current_level()
	Game.current_enemies = current_map.get_current_level().enemies
	get_tree().change_scene_to_file("res://scenes/transition/transition.tscn")
