extends Interactable

func interacted():
	is_interactable = false
	Global.game_pause()
	if Global.current_level == 5: 
		if Global.inventory_item == 6:
			await Global.text_append(
				"> [color=yellow]MC:[/color] May I lend a [color=brown]lighter[/color]?",
				0.03
			)
			await get_tree().create_timer(0.5).timeout
			await Global.text_append(
				"> [color=brown]???:[/color] Sure.",
				0.03
			)
			await get_tree().create_timer(0.5).timeout
			Global.inventory_item = 3
			Global.text_append(
				"You aquired a [color=brown]lighter[/color], now find a [color=purple]fuel[/color]"
			)
		else:
			Global.text_append(
				"Maybe you can ask for [color=brown]lighter[/color], but first you need something [color=dimgray]flammable[/color]"
			)
	else:
		await Global.text_append(
		"> [color=brown]???:[/color] How you doing? Wanna smoke?",
		0.03
		)
		await get_tree().create_timer(0.5).timeout
		await Global.text_append(
			"> [color=yellow]MC:[/color] No, thanks.",
			0.03
		)
	Global.game_resume()
