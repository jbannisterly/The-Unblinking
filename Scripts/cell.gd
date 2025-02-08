extends Node3D

@onready var northWall = $NorthWall; 
@onready var northWallCollider = $NorthWall/NorthWallCollider;
@onready var eastWall = $EastWall; 
@onready var eastWallCollider = $EastWall/EastWallCollider;
@onready var southWall = $SouthWall; 
@onready var southWallCollider = $SouthWall/SouthWallCollider;
@onready var westWall = $WestWall; 
@onready var westWallCollider = $WestWall/WestWallCollider;

func update_faces(tiles):
	var gridPosition = Vector2i(position.x / 10., position.z / 10.);
	if tiles.has(gridPosition + Vector2i.RIGHT):
		eastWall.hide();
		eastWallCollider.disabled = true;
	if tiles.has(gridPosition + Vector2i.LEFT):
		westWall.hide();
		westWallCollider.disabled = true;
	if tiles.has(gridPosition + Vector2i.DOWN):
		northWall.hide();
		northWallCollider.disabled = true;
	if tiles.has(gridPosition + Vector2i.UP):
		southWall.hide();
		southWallCollider.disabled = true;
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
