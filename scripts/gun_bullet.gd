extends CharacterBody2D

const SPEED = 100.0
var ttl = 3

func _ready() -> void:
	velocity = transform.x * Vector2(SPEED, SPEED)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		if ttl == 0: destroy()
		else: ttl -= 1
		velocity = velocity.bounce(collision.get_normal())
		look_at(velocity)
		#if collision.get_collider().has_method("hit"):
		#	collision.get_collider().hit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	destroy()

func destroy():
	queue_free()
