extends Node

const TILE_SIZE = 64
const TILE_SIZE_HALF = 32
const TILE_SIZE_QUARTER = 16 

var current_map: MapData
var current_level: LevelData
var current_enemies: Array[EnemyData]
var current_player: PlayerData
var current_desk: DeskData
var current_hand: DeskData
var current_discard: DeskData
var current_card: BigCard

func reset() -> void:
	current_map = null
	current_level = null
	current_enemies = []
	current_player = null
	current_desk = null
	current_hand = null
	current_discard = null
	current_card = null
