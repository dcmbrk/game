class_name EffectData
extends Resource

enum EffectType { CROSS, PLUS, ENERGY, SHIELD }

@export var type: EffectType
@export var sprite: CompressedTexture2D
@export var description: String = ""
