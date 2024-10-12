extends Node
@onready var cooldown_timer = $Cooldown #Without this Godot gets too much inputs at one time

func _input(event):
	if Input.is_action_pressed("toggle_fullscreen") and cooldown_timer.is_stopped():
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			cooldown_timer.start()
		elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			cooldown_timer.start()
