extends CharacterBody2D
var bullet_scene = preload("res://scenes/enemy/boss_bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var sprite = $Sprite2D
@onready var shoot_sound = $ShootSound
@onready var target = %Player
@onready var rotator = %Rotator
@onready var health_bar = %BossBar

@export var max_health = 10
var health = max_health

func _ready():
	health_bar.max_value = max_health
	update_health_bar()
	shoot_timer.start()

func _process(delta: float) -> void:
	var coord_x = to_local(target.global_position).x
	if coord_x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _on_timer_timeout() -> void:
	call_deferred("shoot")

func update_health_bar():
	health_bar.value = health

func shoot():
	if target and shoot_timer.is_stopped():
		shoot_timer.start()
		#pattern1()
		pattern2()
		

func pattern1():
	var direction = global_position.direction_to(target.global_position)
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.velocity = direction
	bullet_instance.position = global_position
	shoot_sound.play()
	add_child(bullet_instance)
	
func pattern2():
	for s in rotator.get_children():
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.velocity = rotator.global_position.direction_to(s.global_position)
		bullet_instance.position = s.global_position
		add_child(bullet_instance)

func damage():
	health -= 1
	if health == 0: death()
	update_health_bar()

func death():
	OS.alert("You win!", "END")
	get_tree().quit()
	queue_free()
