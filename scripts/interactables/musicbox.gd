extends Interactable

@onready var regular_music : AudioStream = \
preload("res://sounds/temp_active.wav")
@onready var agro_music : AudioStream = \
preload("res://sounds/temp_active.wav")

var first_interaction : bool = true

func interacted():
	is_interactable = \
	Global.current_level == 4 && first_interaction
	Global.info.agro_music = !first_interaction
	first_interaction = false
	Global.info.is_loudly = true
	var music_player : AudioStreamPlayer = \
	get_tree().get_first_node_in_group("Music")
	if music_player == null: return
	if Global.info.agro_music:
		music_player.stream = agro_music
		Global.text_append("Now playing [color=yellow]FishIsGood Battle Theme[/color]")
	else:
		music_player.stream = regular_music
		Global.text_append("Now playing [color=yellow]FishIsGood Battle Theme[/color]")
