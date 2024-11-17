extends Label

func _process(delta: float) -> void:
	var score = GlobalVariables.total_score
	text = "%2d" % [score]
