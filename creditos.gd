extends Control

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("x"):
		get_tree().quit()
	if Input.is_action_pressed("y"):
		get_tree().change_scene_to_file("res://interface.tscn")
