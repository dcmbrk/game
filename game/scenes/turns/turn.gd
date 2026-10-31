class_name Turn
extends TextureRect

func _ready() -> void:
	self.texture = preload("res://assets/ui/turn.svg")
	self.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	self.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
