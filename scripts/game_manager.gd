extends Node
var score = 0

@onready var score_label: Label = $ScoreLabel

func add_point():
	score += 1
	GlobalVariables.total_score += 1
	score_label.text = "You have collected " + str(score) + " coins"

func reset_score():
	GlobalVariables.total_score -= score
