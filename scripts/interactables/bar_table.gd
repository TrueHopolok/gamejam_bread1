extends Interactable

var text : Array[String] = \
[
"> [color=yellow]MC:[/color] Here take a [color=green]drink[/color]. It is at the expense of the bar.",
"> [color=red]Target:[/color] I'm a regular visitor here. I know [color=purple]bartender[/color] very well. You are not him.",
"You understand that you were shot. Another [color=red]failure[/color]...",
]

func _ready():
	super()
	is_interactable = false

func _process(_delta):
	super(_delta)
	is_interactable = Global.info.flooded

func interacted():
	if Global.current_level == 2:
		Global.game_pause()
		await get_tree().create_timer(0.05).timeout
		for line in text:
			await Global.text_append(line, 0.04)
			await get_tree().create_timer(0.7).timeout
		await get_tree().create_timer(1.0).timeout
		Global.save_progress(3)
		Global.game_over(true, "LEVEL COMPLETED?")
	elif Global.current_level == 5:
		Global.game_pause()
		await get_tree().create_timer(0.05).timeout
		await Global.text_append(
			"The [color=red]gun[/color] is in a safe with [color=orange]pin code[/color].",
			0.03
		)
		get_tree().get_first_node_in_group("Pincode").visible = true
	else:
		await get_tree().create_timer(0.05).timeout
		Global.text_append(
			"It didn't work previously, try another plan"
		)
	
