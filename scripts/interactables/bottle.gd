extends Interactable

func _ready():
	super()
	is_interactable = Global.current_level != 1

func interacted():
	Global.inventory_item = 1
	Global.text_append(
		"You have equipped a [color=green]bottle[/color]"
	)
	queue_free()
