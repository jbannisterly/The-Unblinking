extends Node3D;

@export var Map: PackedScene;
@export var Cell: PackedScene;
@export var GRID_SIZE = 10.;

var cells = [];

func generate_map():
	if not Map is PackedScene: return;
	
	var map = Map.instantiate();
	var tilemap = map.get_tilemap();
	var used_tiles = tilemap.get_used_cells();
	map.free();
	for tile in used_tiles:
		var cell = Cell.instantiate() as Node3D;
		add_child(cell);
		#cell.tan
		cell.position = Vector3(tile.x * GRID_SIZE, 0, tile.y * GRID_SIZE);
		cells.append(cell);
	
	for cell in cells:
		cell.update_faces(used_tiles);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var environment = get_tree().root.world.fallback_environment;
	generate_map();
	pass # Replace w2ith function body.
