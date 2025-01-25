extends Node2D

var bullet_scene = preload("res://scenes/gun_bullet.tscn")
@onready var marker = $Marker2D
@onready var cooldown = $CooldownTimer

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("Fire") and cooldown.is_stopped(): 
		call_deferred("shoot")

func shoot():
	cooldown.start()
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = marker.global_position
	bullet_instance.rotation = rotation
	get_tree().get_root().add_child(bullet_instance)
