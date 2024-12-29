extends CharacterBody2D


const SPEED = 100.0

func _ready() -> void:
	velocity = transform.x * Vector2(SPEED, SPEED)

func _physics_process(delta: float) -> void:
	move_and_slide()
