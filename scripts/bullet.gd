extends CharacterBody2D
@export var SPEED = 85
var direction
var spawn_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = direction * SPEED
	global_position = spawn_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_killzone_body_entered(body: Node2D) -> void:
	queue_free()
