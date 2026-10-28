class_name Desk
extends HBoxContainer

var SMALLCARD: PackedScene = preload("res://scenes/small_card/small_card.tscn")
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
			var card_instance: SmallCard = SMALLCARD.instantiate()
			card_instance.load_data(card_data)
			card_instance.setup()
			add_child(card_instance)
	
