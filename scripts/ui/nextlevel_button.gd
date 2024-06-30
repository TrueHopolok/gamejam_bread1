extends Button
func _pressed():
	Global.current_level += 1
	Global.game_start()
