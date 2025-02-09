extends MeshInstance3D

var player: Node3D;
var parent: Node3D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player == null):
		player = get_node("../../Player")
	if (parent == null):
		parent = get_node("../../John")
	if (player != null):
		var pos2D = parent.position
		var playerPos2D = player.position
		var playerFd = -Vector3(player.basis.z.x, 0, player.basis.z.z).normalized()
		pos2D.y = 0
		playerPos2D.y = 0
		var dPos = pos2D - playerPos2D
		# print(dPos.z)
		var targetRotation = atan2(dPos.x, dPos.z) * 180 / PI
		if (dPos.z > 0):
			targetRotation += 180
		# print(targetRotation)
		targetRotation -= parent.rotation_degrees.y
		rotation_degrees.y = targetRotation
	pass
