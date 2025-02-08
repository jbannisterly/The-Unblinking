extends CharacterBody3D;

@export var speed = 100;

var target_velocity = Vector3.ZERO;

var move_forward: float = 0.;
var move_side: float = 0.;

func _physics_process(delta):
	var direction = Vector3.ZERO;
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1;
	if Input.is_action_pressed("move_left"):
		direction.x -= 1;
	if Input.is_action_pressed("move_backward"):
		direction.z += 1;
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1;
		
	if direction != Vector3.ZERO:
		direction = direction.normalized();
		#$Pivot.basis = Basis.looking_at(directionu)
		
	target_velocity.x = direction.x * speed * delta;
	target_velocity.z = direction.z * speed * delta;
	
	velocity = target_velocity;
	move_and_slide();

func handleViewAngles(delta):
	move_forward = 0.;
	move_side = 0.;
