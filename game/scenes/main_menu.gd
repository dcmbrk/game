extends Node

@onready var continue_button: Button = $Buttons/Continue

func _ready() -> void:
	if (true):
		continue_button.disabled = true
