extends VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		play()


func _on_finished() -> void:
	hide()
	pass # Replace with function body.
