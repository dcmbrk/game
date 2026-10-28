class_name MapData
extends Resource

@export var image: CompressedTexture2D
@export var levels: Array[LevelData]
@export var title: String
@export var description: String

var index: int = 0

func get_current_level() -> LevelData:
	return levels[index]

func get_next_level() -> LevelData:
	if index + 1 < levels.size(): 
		return levels[index + 1]
	return null
	
func change_next_level() -> LevelData:
	index += 1
	return get_current_level()
