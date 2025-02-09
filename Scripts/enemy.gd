extends StaticBody3D

var player: Node3D
var totalDeltaTime = 0
var playing = false
var noise: AudioStreamPlayer3D
var jumpscare = false
var jumpTime = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector3(1000, 1000, 1000)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player == null):
		player = get_node("../Player")
	if (player != null):
		var pos2D = position
		var playerPos2D = player.position
		pos2D.y = 0
		playerPos2D.y = 0
		var playerFd = -Vector3(player.basis.z.x, 0, player.basis.z.z).normalized()
		if (jumpscare):
			jumpTime += delta
			Jump(jumpTime, playerFd)
		else:
			# print(pos2D.distance_squared_to(playerPos2D))
			if pos2D.distance_squared_to(playerPos2D) > 3:
				position.y = 0;
				if ((pos2D - playerPos2D).normalized().dot(playerFd)) < 0:
					if floor(totalDeltaTime) < floor(totalDeltaTime + delta):
						if randf() > 0:
							moveBehind(playerFd)
					totalDeltaTime += delta
			else:
				captureCheck(playerFd, playerPos2D, pos2D)
				position.y = 0;

func moveBehind(playerFd):
	position = player.global_position + playerFd * -1.5
	
func captureCheck(playerFd, playerPos2D, pos2D):
	var distance2 = pos2D.distance_squared_to(playerPos2D)
	if distance2 < 3:
		# print((pos2D - playerPos2D).normalized().dot(playerFd))
		if ((pos2D - playerPos2D).normalized().dot(playerFd)) > 0.4:
			if (noise == null):
				noise = get_node("JohnNoise")
			if (noise != null):
				if (!playing):
					noise.play()
					playing = true
					# jumpscare = true
					print("Game Over")
					player.GameOver(position)

func Jump(jumpTime, playerFd):
	position = player.position + playerFd * 2
	# position.y = min(100)
	print(position.y)
	pass

func _on_john_noise_finished() -> void:
	playing = false
	pass # Replace with function body.
