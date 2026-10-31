class_name Hand
extends HBoxContainer

var BIGCARD: PackedScene = preload("res://scenes/big_card/big_card.tscn")
var desk_data: DeskData

func load_data(desk_data: DeskData):
	self.desk_data = desk_data
	
func export_data() -> DeskData:
	return self.desk_data

func setup() -> void:
	_clear()
	_init_cards()

func _clear() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()
		
func _init_cards() -> void:
	if self.desk_data.cards:
		for card_data in self.desk_data.cards:
			var card_instance: BigCard = BIGCARD.instantiate()
			card_instance.load_data(card_data)
			add_child(card_instance)
			card_instance.setup()
