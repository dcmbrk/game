class_name DeskData
extends Resource

@export var cards: Array[CardData]

func move_random_cards(desk_data: DeskData, number_cards: int) -> void:
	if cards.is_empty():
		return
		
	var rng = RandomNumberGenerator.new()
	for i in number_cards:
		var size: int = cards.size()
		var rdn: int = rng.randi_range(0, size - 1)
		var card: CardData = cards[rdn]
		desk_data.cards.append(card)
		cards.remove_at(rdn)
		
func move_all_cards(desk_data: DeskData):
	if cards.is_empty():
		return
	
	for card: CardData in cards:
		desk_data.cards.append(card)
	cards.clear()
