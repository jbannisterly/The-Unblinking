extends Node3D

@onready var northWall = $NorthWall; 
@onready var eastWall = $EastWall; 
@onready var southWall = $SouthWall; 
@onready var westWall = $WestWall; 

func update_faces(tiles):
	var gridPosition = Vector2(position.x / 10., position.z / 10.);
	#if tiles.has(gridPosition + Vector2.RIGHT):
		#eastWall.hide();
	#if tiles.has(gridPosition + Vector2.LEFT):
		#westWall.hide();
	#if tiles.has(gridPosition + Vector2.UP):
		#northWall.hide();
	#if tiles.has(gridPosition + Vector2.DOWN):
		#southWall.hide();
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
