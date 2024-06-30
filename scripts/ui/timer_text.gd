extends Label

func _process(_delta):
	if Global.game_paused: text = "||"
	else: text = str(round(Global.timer.get_time_left()))
