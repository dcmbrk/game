extends Node

const DESK: PackedScene = preload("res://scenes/desk/desk.tscn") 

@onready var player: TextureRect = $Player/Player
@onready var name_label: Label = $Player/Name
@onready var description: Label = $Player/Description
@onready var left_arrow: Button = $Arrows/LeftArrow
@onready var right_arrow: Button = $Arrows/RightArrow
@onready var embark: Button = $Buttons/Embark
@onready var back: Button = $Buttons/Back
@onready var desk: Node = $Desk
@onready var spawn_component: SpawnComponent = $SpawnComponent

@export var players: Array[PlayerData]
@export var desks: Array[DeskData]

var index: int = 0
@onready var size: int = players.size()
@onready var desk_instance = spawn_component.spawn_instance(DESK, desk)

func _ready() -> void:
	right_arrow.button_down.connect(_on_right_arrow_button_down)
	left_arrow.button_down.connect(_on_left_arrow_button_down)
	embark.button_down.connect(_on_embark_button_down)
	back.button_down.connect(_on_back_button_down)
	
	_render_player()
	_render_desk()
	
func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main-menu/main_menu.tscn")
	
func _on_right_arrow_button_down():
	index += 1
	_render_player()
	_render_desk()
	
func _on_left_arrow_button_down():
	index -= 1
	_render_player()
	_render_desk()
	
func _render_player() -> void:
	var current_player: PlayerData = players[index % size]
	player.texture = current_player.sprite
	name_label.text = current_player.get_type_name()
	description.text = current_player.description
	
func _render_desk() -> void:
	var current_desk: DeskData = desks[index % size]
	desk_instance.load_data(current_desk)
	desk_instance.setup()

func _on_embark_button_down():
	_init_game()
	
func _init_game():
	var current_player: PlayerData = players[index % size]
	var current_desk: DeskData = desks[index % size]
	Game.current_player = current_player
	Game.current_desk = current_desk
	Game.current_discard = DeskData.new()
	Game.current_hand = DeskData.new()
	get_tree().change_scene_to_file("res://scenes/new-game/new_game.tscn")
