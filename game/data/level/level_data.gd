class_name LevelData
extends Resource

enum Map { TUTORIAL_ISLAND,  GOLEM_FORTRESS, FOUL_SHRINE }

@export var map: Map
@export var level: int
@export var enemies: Array[EnemyData] 
