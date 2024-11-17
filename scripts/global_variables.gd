extends Node

var total_time := 0.0
var total_score: int = 0

func _process(delta: float) -> void:
	total_time += delta
