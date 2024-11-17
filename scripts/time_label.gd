extends Label

var time_elapsed := 0.0

func _process(delta: float) -> void:
	
	#copypasted from WhateverClock
	time_elapsed = GlobalVariables.total_time
	var seconds = int(time_elapsed)%60
	var minutes = int(time_elapsed)/60
	var hours = int(time_elapsed)/60/60
	text = "%02d:%02d:%02d" % [hours, minutes, seconds]
