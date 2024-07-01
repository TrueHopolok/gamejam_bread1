extends Button

@export var line_edit : LineEdit

func _pressed():
	get_parent().visible = false
	if !(line_edit.text.is_valid_int()) || !(int(line_edit.text) == 4629):
		Global.game_over(false, "INCORRECT PIN CODE")
		return
	Global.game_over(false, "ENDING 5")
