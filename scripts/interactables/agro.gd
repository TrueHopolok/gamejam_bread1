extends Interactable

var text : Array[String] = \
[
"> [color=green]???:[/color] Hey ****, that's my bottle",
"This person even though is drunk, still is stronger then you... [color=red]Failure[/color]...",
]

func _process(_delta):
	super(_delta)
	if len(area_node.get_overlapping_areas()) > 0 \
	&& Global.info.agro_bottle_broken:
		Global.info.agro_bottle_broken = false
		Global.game_pause()
		ending3()
	if Global.info.agro_music: is_interactable = true

func ending3():
	for line in text:
		await Global.text_append(line, 0.04)
		await get_tree().create_timer(0.7).timeout
	await get_tree().create_timer(1.0).timeout
	Global.save_progress(4)
	Global.game_over(true, "LEVEL COMPLETED?")

func interacted():
	if Global.info.agro_music:
		Global.game_pause()
		await Global.text_append(
			"> [color=green]???:[/color] Who the **** turned on this music?",
			0.06
		)
		await get_tree().create_timer(0.7).timeout
		await Global.text_append(
			"> [color=yellow]MC:[/color] It was [color=red]him[/color].",
			0.04
		)
		await get_tree().create_timer(0.7).timeout
		await Global.text_append(
			"Even though plan didn't work, this whole situation was really useful. [color=purple]Bartender[/color] has a [color=red]gun[/color].",
			0.04
		)
		await get_tree().create_timer(2.5).timeout
		Global.save_progress(5)
		Global.game_over(true, "LEVEL COMPLETED?")
	else:
		Global.game_pause()
		is_interactable = false
		await Global.text_append(
			"> [color=green]???:[/color] Ugh...   go **** yourself",
			0.1
		)
		Global.game_resume()
