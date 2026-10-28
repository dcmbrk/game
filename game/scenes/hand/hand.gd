class_name Hand
extends HBoxContainer

var BIGCARD: PackedScene = preload("res://scenes/big_card/big_card.tscn")
var cards: Array[CardData]

func load_data(desk_data: DeskData):
	if desk_data:
		cards = desk_data.cards
	
func export_data() -> DeskData:
	var desk_data: DeskData = DeskData.new()
	desk_data.cards = cards
	return desk_data

func setup() -> void:
	_clear()
	_init_cards()

func _clear() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()
		
func _init_cards() -> void:
	if cards:
		for card_data in cards:
			var card_instance: BigCard = BIGCARD.instantiate()
			card_instance.load_data(card_data)
			add_child(card_instance)
			card_instance.setup()
	
