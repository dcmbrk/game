class_name SmallCard
extends VBoxContainer

var PIECE: PackedScene = preload("res://scenes/piece/piece.tscn")
var EFFECT: PackedScene = preload("res://scenes/effect/effect.tscn")

var type: CardData.PieceType
var sprite: CompressedTexture2D
var effects: Array[EffectData]
var attack: AttackData


func load_data(card_data: CardData) -> void:
	type = card_data.type
	sprite = card_data.sprite
	effects = card_data.effects
	attack = card_data.attack	

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
	for child in get_children():
		remove_child(child)
		child.queue_free()

func _init_piece():
	var piece_instance: Piece = PIECE.instantiate()
	piece_instance.texture = sprite
	add_child(piece_instance)
	
func _init_effects():
	if effects:
		for effect in effects:
			var effect_instance: Effect = EFFECT.instantiate()
			effect_instance.texture = effect.sprite
			add_child(effect_instance)
