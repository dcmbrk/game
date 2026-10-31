class_name Desk
extends HBoxContainer

var SMALLCARD: PackedScene = preload("res://scenes/small_card/small_card.tscn")
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
	if desk_data.cards:
		for card_data in desk_data.cards:
			var card_instance: SmallCard = SMALLCARD.instantiate()
			card_instance.load_data(card_data)
			card_instance.setup()
			add_child(card_instance)
	
