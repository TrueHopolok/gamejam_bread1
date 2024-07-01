extends Interactable

@onready var lab_music : AudioStream = preload("res://sounds/lab.mp3") 

var text_bar : Array[String] = \
[
"> [color=yellow]MC:[/color] I'm not from here, I’m from [color=dimgray]Birkenhead[/color]. My city never sleeps, but here... What kind of city do you have here?",
"> [color=red]Target:[/color] Here life goes on fast. No room for the [color=slateblue]lonely[/color].",
"> [color=yellow]MC:[/color] There shouldn't be any [color=slateblue]lonely[/color] people here, right?",
"> [color=red]Target:[/color] [color=darkgray]Right.[/color]",
"> [color=yellow]MC:[/color] If I were you, I would leave this place to [color=crimson]hell[/color].",
"> [color=red]Target:[/color] If you were [color=yellow]me[/color]?",
"> [color=yellow]MC:[/color] Sorry?",
"> [color=red]Target:[/color] If you were [color=yellow]me[/color], you wouldn't drink a glass with [color=green]poison[/color].",
"> [color=yellow]MC:[/color] [color=gray]What?? How you?..[/color]",
"> [color=red]Target:[/color] Dying from the [color=green]poison[/color] you added yourself.",
"> [color=yellow]MC:[/color] [color=dimgray]What do you mean? I...[/color]",
"> [color=red]Target:[/color] You're not the first one to try to [color=green]poison[/color] me, and you're not the first whose drinks I've switched.",
]

var text_lab : Array[String] = \
[
"> [color=yellow]MC:[/color] Another failure...",
"> [color=tan]???:[/color] You died. [color=slateblue]Again[/color]. We have more attempts. Let's go through it all again.",
"> [color=yellow]MC:[/color] I remember. We need to eliminate the [color=red]Target[/color]. He's in the bar. I need to find a way to [color=red]kill him[/color] to prevent a [color=red]catastrophe[/color] in the [color=darkgreen]future[/color].",
"> [color=tan]???:[/color] You must [color=red]kill him[/color] before [color=red]he[/color] realizes what's happening. You have a whole [color=yellow]60 seconds[/color], but every time you [color=red]fail[/color]!",
"> [color=yellow]MC:[/color] 60 seconds isn't much, you know?",
"> [color=tan]???:[/color] You have no choice. [color=darkgreen]The future is at stake.[/color] You must use each attempt wisely. What other ideas do you have?",
"> [color=yellow]MC:[/color] I'll try a different approach. Maybe use a [color=aqua]distraction[/color] or find another [color=green]weapon[/color].",
"> [color=tan]???:[/color] Fine. Be more attentive this time and don't let him outsmart you again. Remember, the [color=darkgreen]future[/color] is on the line.",
]

func _process(_delta):
	super(_delta)
	visible = Global.info.drink_ordered
	area_node.get_child(0).disabled = !visible 

func interacted():
	if Global.current_level == 1:
		Global.game_pause()
		is_interactable = false
		visible = false
		for line in text_bar:
			await Global.text_append(line, 0.04)
			await get_tree().create_timer(0.7).timeout
		var lab : AnimationPlayer = get_tree().get_first_node_in_group("LaborotoryAnimation")
		lab.play("fade_to_black")
		var music_node : AudioStreamPlayer = get_tree().get_first_node_in_group("Music")
		music_node.stop()
		await get_tree().create_timer(1.0).timeout
		lab.play("fade_to_normal")
		await get_tree().create_timer(1.0).timeout
		music_node.stream = lab_music
		music_node.play()
		for line in text_lab:
			await Global.text_append(line, 0.04)
			await get_tree().create_timer(0.7).timeout
		await get_tree().create_timer(1.0).timeout
		Global.save_progress(2)
		Global.game_over(true, "LEVEL COMPLETED?")
	elif Global.current_level != 5:
		is_interactable = false
		Global.text_append(
			"You already tried to [color=green]poison[/color] the [color=red]target[/color], no point in continuing"
		)
	elif Global.inventory_item != 3:
		Global.text_append(
			"That can be used as a [color=brown]fuel[/color]"
		)
	else:
		Global.inventory_item = 5
		is_interactable = false
		Global.text_append(
			"You made an interesting [color=orange]coctail[/color]"
		)
		queue_free()
