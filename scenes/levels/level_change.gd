extends Area2D

@export var level_path: String = "res://scenes/levels/level2.tscn"

func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file(level_path)
