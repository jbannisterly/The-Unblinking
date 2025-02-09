extends Area3D

@export var winScreen: Control;
#@onready var winScreen = $WinScreen;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies();
	for body in bodies:
		if body.is_in_group("Player"):
			if (body.has_game_finished()):
				winScreen.visible = true;
				var minutes = body.time / 60.;
				var seconds = fmod(body.time, 60.);
				body.gameOver = true;
				winScreen.get_child(1).text = "%02.0f:%2.3f" % [minutes, seconds];
