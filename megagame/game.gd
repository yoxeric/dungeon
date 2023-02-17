extends Node2D

const TILE_SIZE = 32

const LEVEL_SIZES = [
	Vector2(30,30),
	Vector2(35,35),
	Vector2(40,40),
	Vector2(45,45),
	Vector2(50,50),
]

const LEVEL_ROOM_CONST = [5,7,9,12,15]
const MIN_ROOM_DIMENSION = 5;
const MAX_ROOM_DIMENSION = 8

enum Tile {Door, Floor, Lader, Stone , Wall}

# Level
var level_num = 0
var map = []
var rooms = []
var level_size

# refs

onready var tile_map = $TileMap
onready var player = $Player

# state

var player_tile
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_size(Vector2(1280,720))
	randomize()
	build_level()

func build_level():
	
	rooms.clear()
	map.clear()
	tile_map.clear()
	
	level_size = LEVEL_SIZES[level_num]
	for x in range(level_size.x):
		map.append([])
		for y in range(level_size.y):
			map[x].append(Tile.Floor)
			tile_map.set_cell(x, y, Tile.Floor)

	var free_regions = [Rect2(Vector2(2, 2), level_size - Vecto2(4, 4))]
	var num_rooms = LEVEL_ROOM_CONST[level_num]
	for i in range(num_rooms):
		add_room(free_region)
		if free_region.empty():
			break


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
