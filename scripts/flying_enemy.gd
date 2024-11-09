extends CharacterBody2D
var target : Node2D
var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var sprite = $Sprite2D
@onready var shoot_sound = $ShootSound

func _process(delta: float) -> void:
	if target:
		var coord_x = to_local(target.global_position).x
		if coord_x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true

func _on_timer_timeout() -> void:
	shoot()

func _on_vision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		target = body
		shoot_timer.start()

func _on_vision_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		target = null
		shoot_timer.stop()

func shoot():
	if target:
		var direction = global_position.direction_to(target.global_position)
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.direction = direction
		bullet_instance.spawn_pos = global_position
		shoot_sound.play()
		get_tree().get_root().add_child(bullet_instance)
