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

var card_data: CardData

func load_data(card_data: CardData) -> void:
	self.card_data = card_data

func export_data() -> CardData:
	return self.card_data

func setup() -> void:
	_clear()
	_init_piece()	
	_init_effects()
		
func _clear() -> void:
	for child in effects_container.get_children():
		effects_container.remove_child(child)
		child.queue_free()

func _init_piece():
	piece.texture = self.card_data.sprite
	
func _init_effects():
	if self.card_data.effects:
		for effect in self.card_data.effects:
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
	
