extends Area2D

@onready var animation_player = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.add_jump()
		animation_player.play("pickup")

func _on_pickup_sound_finished() -> void:
	queue_free()
