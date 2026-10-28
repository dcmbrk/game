class_name BigCard
extends Control

signal click_in(card_instance: BigCard)
signal click_out(card_instance: BigCard)
signal hover_in(card_instance: BigCard)
signal hover_out(card_instance: BigCard)

var EFFECT: PackedScene = preload("res://scenes/effect/effect.tscn")

@onready var effects_container: HBoxContainer = $Effects
@onready var piece: Piece = $Piece
@onready var border: ColorRect = $Border

var type: CardData.PieceType
var sprite: CompressedTexture2D
var effects: Array[EffectData]
var attack: AttackData

var down

func load_data(data: CardData) -> void:
	type = data.type
	sprite = data.sprite
	effects = data.effects
	attack = data.attack

func export_data() -> CardData:
	var card_data: CardData = CardData.new()
	card_data.type = type
	card_data.sprite = sprite
	card_data.effects = effects
	card_data.attack = attack
	return card_data

func setup() -> void:
	_clear()
	_init_piece()	
	_init_effects()
		
func _clear() -> void:
	for child in effects_container.get_children():
		effects_container.remove_child(child)
		child.queue_free()

func _init_piece():
	piece.texture = sprite
	
func _init_effects():
	if effects:
		for effect in effects:
			var effect_instance: Effect = EFFECT.instantiate()
			effect_instance.texture = effect.sprite
			effects_container.add_child(effect_instance)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			if self == Game.current_card:
				Game.current_card.click_out.emit(Game.current_card)
				Game.current_card.hand_down()
				Game.current_card = null
				return
			else:
				if Game.current_card:
					Game.current_card.click_out.emit(Game.current_card)
					Game.current_card.hand_down()
				Game.current_card = self
				Game.current_card.click_in.emit(Game.current_card)
				Game.current_card.hand_up()
			


func _on_area_2d_mouse_entered() -> void:
	if Game.current_card:
		return
	else:
		hover_in.emit(self)
		border.color = Color.BLACK


func _on_area_2d_mouse_exited() -> void:
	if Game.current_card:
		return
	else:
		hover_out.emit(self)
		border.color = Color("#272744")
		
func hand_up() -> void:
	border.color = Color("#f2d3ab")
	position.y -= 10

func hand_down() -> void:
	border.color = Color("#272744")
	position.y += 10
	
