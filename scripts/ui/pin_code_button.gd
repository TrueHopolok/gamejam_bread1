extends Button

var ending_text : Array[String] = \
[
"> [color=red]Target:[/color] Huh?!",
"> [color=yellow]MC:[/color] Finally... At least this time [color=red]you[/color] won't survive.",
"As [color=red]target[/color] was dying, [color=yellow]you and he[/color] made an eye contact.",
"> [color=red]Target:[/color] [color=gray]you... and me...[/color]",
"> [color=yellow]MC:[/color] [color=gray]No, that can be.[/color]",
]

var final_text : Array[String] = \
[
"> [color=tan]???:[/color] [color=yellow]Subject[/color] finally finished the task. [color=darkgreen]He eliminated himself in the past.[/color]",
"> [color=orange]MC:[/color] What does it mean... LET ME OUT!",
"> [color=tan]???:[/color] Test is over, timeline should be fixing itself soon.",
]

@export var line_edit : LineEdit
@onready var shot_sfx : AudioStream = preload("res://sounds/shot.mp3")
@onready var lab_music : AudioStream = preload("res://sounds/lab.mp3")

func _pressed():
	get_parent().visible = false
	if !(line_edit.text.is_valid_int()) || !(int(line_edit.text) == 4629):
		Global.game_over(false, "INCORRECT PIN CODE")
		return
	Global.inventory_item = 4
	var music_player : AudioStreamPlayer = get_tree().get_first_node_in_group("Music")
	music_player.stop()
	await get_tree().create_timer(0.5).timeout
	music_player.stream = shot_sfx
	music_player.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().get_first_node_in_group("LaborotoryAnimation").play("fade_to_black")
	await get_tree().create_timer(1.0).timeout
	for line in ending_text:
		await Global.text_append(line, 0.04)
		await get_tree().create_timer(0.7).timeout
	await Global.text_append("> [color=orange]MC:[/color] [color=dimgray]We are the same person . . . [/color]\n", 0.2)
	await get_tree().create_timer(2.0).timeout
	get_tree().get_first_node_in_group("LaborotoryAnimation").play("fade_to_normal")
	music_player.stream = lab_music
	music_player.play()
	for line in final_text:
		await Global.text_append(line, 0.04)
		await get_tree().create_timer(0.7).timeout
	await Global.text_append("> [color=tan]???:[/color] [color=yellow]Subject[/color] will disappear from timeline.", 0.1)	
	await get_tree().create_timer(2.0).timeout
	Global.game_over(false, "THE END")
