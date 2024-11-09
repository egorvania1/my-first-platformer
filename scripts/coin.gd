extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pickup_sound = $PickupSound

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	if pickup_sound.is_playing():
		pickup_sound.stop()
	pickup_sound.play()
	animation_player.play("pickup")
