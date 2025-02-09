extends CharacterBody3D;

@onready var points = $Screen;

@export var speed = 100;
@export var mouse_sense_x = 0.5;
@export var mouse_sense_y = 0.5;

var target_velocity = Vector3.ZERO;

var move_forward: float = 0.;
var move_side: float = 0.;
var look_x: float = 0.;
var look_y: float = 0.;
var capture_mouse: bool = false;
var can_start: bool = false;
var noise: AudioStreamPlayer
var noise2: AudioStreamPlayer

var game_finished = false;

var current_score = 0;
var required_score = 0;

var gameOver = false
var targetRotation = 0
var time = 0.;

func _process(delta: float) -> void:
	if gameOver:
		rotation_degrees.x = 30
		rotation_degrees.y = targetRotation

func capture():
	if capture_mouse:
		Input.set_mouse_mode(Input.MouseMode.MOUSE_MODE_CAPTURED);
	else:
		Input.set_mouse_mode(Input.MouseMode.MOUSE_MODE_VISIBLE);

func toggle_capture():
	capture_mouse = !capture_mouse;
	capture();

func _ready():
	capture();

func _input(event):
	if can_start and not gameOver:
		if event is InputEventMouseMotion:
			look_x += -event.relative.x * mouse_sense_x;
			look_y += -event.relative.y * mouse_sense_y;
		
			look_y = clamp(look_y, -89, 89);

func _physics_process(delta):
	#if Input.is_action_just_pressed("toggle_capture"):
		#toggle_capture();
	if Input.is_action_just_pressed("Escape"):
		get_tree().quit();
		
	if can_start and not gameOver:
		if can_start && !capture_mouse:
			toggle_capture();
			
		time += delta;
		var direction = Vector3.ZERO;
	
		rotation_degrees.y = look_x;
		rotation_degrees.x = look_y;
	
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
		
		target_velocity.x = direction.x * speed;
		target_velocity.z = direction.z * speed;
	
		velocity = basis * target_velocity;
		
		var prevY = position.y;
		move_and_slide();
		position.y = prevY;
		
	if gameOver:
		if capture_mouse:
			toggle_capture();
		if Input.is_mouse_button_pressed(1):
			get_tree().reload_current_scene();
		
func add_to_required_score():
	required_score += 1;
	
func increase_score():
	if (noise == null):
		noise = get_node("Noise")
	if (noise != null):
		current_score += 1;
		#print();
		points.text = "Supervision Work Collected: %d / %d" % [current_score, required_score];
		noise.play()
		
		if (current_score == required_score):
			game_finished = true;
			points.text = "Return to the Intel Lab";
			if (noise2 == null):
				noise2 = get_node("Noise2")
			if (noise2 != null):
				noise2.play()

			
func has_game_finished():
	return game_finished;

func _on_cutscene_finished() -> void:
	can_start = true;

func GameOver(targetPosition):
	gameOver = true;
	var deltaPos = targetPosition - position
	deltaPos.y = 0
	targetRotation = atan2(deltaPos.x, deltaPos.z) * 180 / PI
	if (deltaPos.z > 0):
		targetRotation += 180
		
func GetFractionGot():
	return current_score
