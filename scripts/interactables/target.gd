extends Interactable

var text : Array[String] = \
[
"> [color=yellow]YOU (MC):[/color] Evening. Mind if I join you?",
"> [color=red]Target:[/color] Sure, have a seat.",
"> [color=yellow]MC:[/color] May I offer you a drink?",
"> [color=red]Target:[/color] I won't say no.",
]

func _ready():
	super()
	is_interactable = Global.current_level == 1

func interacted():
	Global.game_pause()
	is_interactable = false
	for line in text:
		await Global.text_append(
			line,
			0.04
		)
		await get_tree().create_timer(0.6).timeout
	Global.info.talked_with_target = true
	Global.game_resume()
