extends Area3D

var original_position = Vector3(0., 0., 0.);
var t = 0.;
var triggered = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_monitoring(true);
	original_position = position;

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
