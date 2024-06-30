extends Interactable

@export var run_time : int = 300
@onready var exit_marker : Marker2D = $Marker2D
var run_speed : float
var exit_position : float
var timer : Timer
var have_item : bool = true
var running : bool = false

func _ready():
	super()
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(30.0)
	timer.timeout.connect(finished_cleaning)
	exit_position = exit_marker.global_position.x
	run_speed = (exit_position - global_position.x) / run_time

func _process(_delta):
	super(_delta)
	if running:
		if run_speed > 0.0: 
			global_position.x = \
			clampf(global_position.x + run_speed, global_position.x, exit_position)
		else:
			global_position.x = \
			clampf(global_position.x + run_speed, exit_position, global_position.x)
		if global_position.x == exit_position:
			queue_free()
	else:
		timer.paused = Global.game_paused

func finished_cleaning():
	Global.info.cleaner_cleaning = false
	is_interactable = false
	running = true

func interacted():
	if have_item:
		have_item = false
		Global.inventory_item = 6
		is_interactable = Global.current_level == 5
		Global.text_append(
			"You aquired a [color=dimgray]rag[/color]"
		)
	elif Global.inventory_item == 5:
		Global.game_pause()
		Global.text_append(
			"ENDING 5.cleaner"
		)
	else:
		Global.text_append(
			"Maybe try to make [color=orange]something[/orange] instead of disturbing [color=aqua]him[/color]"
		)
