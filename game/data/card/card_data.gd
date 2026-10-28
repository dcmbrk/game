class_name CardData
extends Resource

enum PieceType { PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING }

@export var type: PieceType
@export var effects: Array[EffectData]
@export var attack: AttackData
@export var sprite: CompressedTexture2D
