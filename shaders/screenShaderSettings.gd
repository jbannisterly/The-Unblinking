extends MeshInstance3D

var time = 0.;
#@export var shader_mat: Shader;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta;
	get_active_material(0).set("shader_parameter/time", time);
	#shader_mat.set_uniform_variable("time", time);
