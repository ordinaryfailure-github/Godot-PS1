extends Node

func _input(event):
	if Input.is_action_just_pressed("quit"):
		queue_free()
		get_tree().quit()
	
	if Input.is_action_just_pressed("unlock_cursor"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_mouse_button_pressed(1) and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
