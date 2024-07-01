extends Interactable

var text : Array[String] = \
[
"> [color=purple]Bartender:[/color] What are you doing?.. Don't hurt me... ",
"> [color=yellow]MC:[/color] Be quiet. I won't hesitate to use [color=green]this[/color]. Give me a [color=orange]pin[/color] to unlock a [color=red]gun[/color].",
"After some interegation, the only 2 things you were able in time to get are:",
"1) [color=orange]4 and 6[/color] are the first two digits of the pin",
"2) [color=aqua]Janitor[/color] also knows a code",
]

@export var run_time : int = 300
@onready var toilets_marker : Marker2D = $Marker2D
var run_away : bool = false
var run_speed : float
var toilets_position : float

func _ready():
	super()
	is_interactable = Global.current_level != 1 
	toilets_position = toilets_marker.global_position.x
	run_speed = (toilets_position - global_position.x) / run_time

func _process(_delta):
	super(_delta)
	if Global.current_level == 1:
		is_interactable = Global.info.talked_with_target
	if Global.info.flooded && !run_away:
		is_interactable = false
		if run_speed > 0.0: 
			global_position.x = \
			clampf(global_position.x + run_speed, global_position.x, toilets_position)
		else:
			global_position.x = \
			clampf(global_position.x + run_speed, toilets_position, global_position.x)
		if global_position.x == toilets_position:
			run_away = true
			if Global.current_level == 5 && Global.inventory_item == 2:
				ending()

func ending():
	for line in text:
		await Global.text_append(line, 0.04)
		await get_tree().create_timer(0.7).timeout
	await get_tree().create_timer(1.0).timeout
	Global.game_over()

func interacted():
	Global.game_pause()
	Global.info.drink_ordered = true
	Global.info.talked_with_target = false
	is_interactable = false
	if Global.current_level == 1:
		await Global.text_append(
			"> [color=yellow]MC:[/color] [color=purple]Bartender[/color], two Bloody Marys, please.",
			0.03
		)
	else:
		await Global.text_append(
			"> [color=yellow]MC:[/color] May I have a drink, [color=purple]Bartender?[/color]",
			0.03
		)
	Global.game_resume()
