extends Node2D

@export var entering_time : int = 300
@export var border_vector : Vector2 = Vector2(0, 1152)
@export var movement_speed : float = 3.0
@onready var entering_marker : Marker2D = $Marker2D
var entering_position : float
var entering_speed : float
@onready var animation_node : AnimatedSprite2D = $AnimatedSprite2D
var animation_locked : bool = false

func _ready():
	animation_node.animation_finished.connect(
		func(): animation_locked = false
	)
	entering_position = entering_marker.global_position.x
	entering_speed = (entering_position - global_position.x) / entering_time

func _process(_delta):
	if !Global.info.started:
		if entering_speed > 0.0: 
			global_position.x = \
			clampf(global_position.x + entering_speed, global_position.x, entering_position)
		else:
			global_position.x = \
			clampf(global_position.x + entering_speed, entering_position, global_position.x)
		if global_position.x == entering_position:
			Global.info.started = true
			Global.game_resume()
		return
	elif Global.game_paused: return
	var move_direction : float = Input.get_axis("move_left", "move_right")
	global_position.x = \
		clampi(
			global_position.x + move_direction * movement_speed,
			border_vector.x,
			border_vector.y
		)
	if Input.is_action_just_pressed("interact"):
		animation_locked = true
		animation_node.play("interact")
	elif !animation_locked: 
		if move_direction != 0:
			animation_node.play("walk")
		else:
			animation_node.play("idle")
