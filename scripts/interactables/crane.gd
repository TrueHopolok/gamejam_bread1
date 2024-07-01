extends Interactable

func _ready():
	super()
	is_interactable = Global.current_level != 1

func interacted():
	Global.game_pause()
	get_tree().get_first_node_in_group("Pincode").visible = true
	return
	match Global.current_level:
		3:
			if Global.inventory_item != 1:
				Global.text_append(
					"[color=aqua]Flood[/color] didn't work, but maybe [color=green]something[/color] could be [color=yellow]made[/color] here"
				)
			elif !Global.info.is_loudly:
				Global.text_append(
					"Breaking bottle is too [color=red]loud[/color]"
				)
			elif Global.info.cleaner_cleaning:
				Global.text_append(
					"[color=yellow]Wait[/color] for [color=aqua]janitor[/color] to go away"
				)
			else:
				Global.info.agro_bottle_broken = true
				Global.inventory_item = 2
				is_interactable = false
				Global.text_append(
					"You made [color=green]something[/color] useful :)"
				)
		2:
			if Global.info.cleaner_cleaning:
				Global.text_append(
					"Good idea to [color=aqua]flood[/color] the toilets, but maybe try to [color=yellow]wait[/color] for [color=aqua]janitor[/color] to go away"
				)
			else:
				Global.info.flooded = true
				is_interactable = false
				Global.text_append(
					"You [color=aqua]flooded[/color] the toilets, try to use that [color=purple]opportunity[/color]"
				)
		4:
			is_interactable = false
			Global.text_append(
				"[color=aqua]This[/color] isn't helpful for the current plan"
			)
		5:
			if Global.info.cleaner_cleaning:
				Global.text_append(
					"Gotta either [color=aqua]wait[/color] or [color=green]make something[/color]"
				)
			elif Global.inventory_item == 2:
				Global.game_pause()
				Global.info.flooded = true
				is_interactable = false
				await Global.text_append(
					"You [color=aqua]flooded[/color] the toilets...\nIt is time for [color=purple]interigation[/color]",
					0.03
				)
				await get_tree().create_timer(0.5).timeout
				Global.text_append(
					"ENDING 5.barman"
				)
			elif Global.inventory_item == 1:
				if Global.info.is_loudly:
					Global.inventory_item = 2 
					Global.text_append(
						"You made a [color=green]weapon[/color]. Now next [color=aqua]step...[/color]"
					)
				else:
					Global.text_append(
						"Did you forget how to make  [color=green]one[/color] :("
					)
			else:
				Global.info.flooded = true
				is_interactable = false
				Global.text_append(
					"You [color=aqua]flooded[/color] the toilets, try to use that [color=purple]opportunity[/color]"
				)
