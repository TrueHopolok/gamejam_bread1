extends Interactable

@onready var regular_music : AudioStream = \
preload("res://sounds/musicbox.mp3")
@onready var agro_music : AudioStream = \
preload("res://sounds/nenravitsja.mp3")

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
		Global.text_append("Now playing [color=yellow]dislike[/color]")
	else:
		music_player.stream = regular_music
		Global.text_append("Now playing [color=yellow]melody[/color]")
	music_player.play()
