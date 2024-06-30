extends Node

@onready var prefab_game : PackedScene = preload("res://scenes/bar.tscn")
@onready var prefab_mainmenu : PackedScene = preload("res://scenes/main_menu.tscn")

var timer : Timer = Timer.new()
var inventory_item : int = 0
var current_level : int = 5
var info : GameInfo = GameInfo.new()
var cutscene : bool = false
var game_paused : bool = false

##============================##
##         FOR DEBUG          ##
func _input(event):
	if Input.is_action_just_pressed("debug"):
		if game_paused: game_resume()
		else: game_pause()
## MUST BE DELETED ON RELEASE ##
##============================##

func _ready():
	Engine.max_fps = 60
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(game_over)

func text_append(text : String, char_speed : float = 0):
	var label_node : RichTextLabel = \
	get_tree().get_first_node_in_group("TextWindow")
	label_node.text += "\n"
	var i : int = 0
	while i < len(text):
		if text[i] == "[":
			while text[i] != "]" && i < len(text):
				label_node.text += text[i]
				i += 1
			if i == len(text): return
		label_node.text += text[i]
		i += 1
		if char_speed > 0.01: await get_tree().create_timer(char_speed).timeout

func text_clear():
	var label_node : RichTextLabel = \
	get_tree().get_first_node_in_group("TextWindow")
	label_node.text = "[color=aqua]You walked into a bar...[/color]\n"

func game_pause():
	game_paused = true
	timer.paused = true

func game_resume():
	game_paused = false
	timer.paused = false

func game_over(completed : bool = false, reason : String = "TIME IS UP"):
	game_paused = true
	timer.paused = true
	var gameover_scene : CanvasLayer = get_tree().get_first_node_in_group("GameoverScreen")
	gameover_scene.visible = true
	var gameover_title : Label = get_tree().get_first_node_in_group("GameoverTitle")
	gameover_title.text = "GAMEOVER: " + reason
	var gameover_button : Button = get_tree().get_first_node_in_group("GameoverNextlevel")
	gameover_button.disabled = !completed
	var gameover_animation : AnimationPlayer = get_tree().get_first_node_in_group("GameoverAnimation")
	gameover_animation.play("fade_to_black")

func game_start():
	for child in get_tree().get_root().get_children():
		if child.name != "Global": child.queue_free()
	get_tree().get_root().add_child(prefab_game.instantiate())
	var gameover_scene : CanvasLayer = get_tree().get_first_node_in_group("GameoverScreen")
	gameover_scene.visible = false
	text_clear()
	game_paused = true
	timer.paused = true
	timer.start(60.0)
	info = GameInfo.new()

func save_progress(unlocked_level : int):
	if !FileAccess.file_exists("user://completed.levels"):
		var file = FileAccess.open("user://completed.levels", FileAccess.WRITE)
		file.store_8(1)
		file.close()
	var file = FileAccess.open("user://completed.levels", FileAccess.READ)
	var completed_level = file.get_8()
	file.close()
	if completed_level > unlocked_level:
		return
	file = FileAccess.open("user://completed.levels", FileAccess.WRITE)
	file.store_8(unlocked_level)
	file.close()

func menu_load():
	for child in get_tree().get_root().get_children():
		if child.name != "Global": child.queue_free()
	get_tree().get_root().add_child(prefab_mainmenu.instantiate())
