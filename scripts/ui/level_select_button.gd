extends TextureButton

@export_range(1, 5) var loaded_level : int = 1

func _ready():
	if !FileAccess.file_exists("user://completed.levels"):
		var file = FileAccess.open("user://completed.levels", FileAccess.WRITE)
		file.store_8(1)
		file.close()
	var file = FileAccess.open("user://completed.levels", FileAccess.READ)
	var completed_level = file.get_8()
	file.close()
	visible = clampi(completed_level, 1, 5) >= loaded_level
	disabled = !visible

func _pressed():
	Global.current_level = loaded_level
	Global.game_start()
