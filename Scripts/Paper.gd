extends Area3D

var original_position = Vector3(0., 0., 0.);
var t = 0.;
var triggered = false;

@onready var collider = $CollisionShape3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_monitoring(true);
	original_position = position;

func setActive():
	var gridPosition = Vector2i(get_parent().position.x / 10., get_parent().position.z / 10.);
	
	var range_x = 3;
	var range_y = 2;
		
	#if (gridPosition.x >= -range && gridPosition.y >= -range && gridPosition.x <= range && gridPosition.y <= range):
	if (gridPosition.x >= -range_x && gridPosition.x <= range_x) && (gridPosition.y >= -range_y && gridPosition.y <= range_y):
		self.visible = false;
		collider.disabled = true;
	else:
		var player = get_tree().get_first_node_in_group("Player");
		player.add_to_required_score();

func _process(delta: float) -> void:
	t += delta;
	position.y = original_position.y + sin(t) * 0.5 + 0.3;
	rotation.y = t;
	
	if !triggered:
		var bodies = get_overlapping_bodies();
		for body in bodies:
			if body.is_in_group("Player"):
				body.increase_score();
				visible = false;
				triggered = true;
