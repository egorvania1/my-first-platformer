extends CharacterBody2D
@export var SPEED = 85
#direction and spawn_pos is being set by parent node
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity *= SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()

func _on_life_timer_timeout() -> void:
	queue_free()

func _on_killzone_body_entered(body: Node2D) -> void:
	destroy()

func destroy():
	velocity *= 0
	animation_player.play("destroy")
	await animation_player.animation_finished
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
