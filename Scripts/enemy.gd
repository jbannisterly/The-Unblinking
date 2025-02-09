extends StaticBody3D

var player: Node3D
var totalDeltaTime = 0
var playing = false
var noise: AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector3(1000, 1000, 1000)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player == null):
		player = get_node("../Player")
	if (player != null):
		if position.distance_squared_to(player.position) > 3:
			if (player.position - position).dot(player.basis.z) < 0:
				if floor(totalDeltaTime) < floor(totalDeltaTime + delta):
					if randf() > 0.8:
						moveBehind()
				totalDeltaTime += delta
		captureCheck()

func moveBehind():
	position = player.global_position + player.basis.z * 1.5
	
func captureCheck():
	var distance2 = position.distance_squared_to(player.position)
	if distance2 < 3:
		if (player.position - position).dot(player.basis.z) > 0:
			if (noise == null):
				noise = get_node("JohnNoise")
			if (noise != null):
				if (!playing):
					noise.play()
					playing = true
				


func _on_john_noise_finished() -> void:
	playing = false
	pass # Replace with function body.
