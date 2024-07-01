class_name Interactable extends Node2D

@export var is_interactable : bool = true

@onready var area_node : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	if animated_sprite != null: animated_sprite.play("default")

func _process(_delta):
	if !Global.game_paused \
	&& is_interactable \
	&& len(area_node.get_overlapping_areas()) > 0:
		if sprite != null: sprite.material.set_shader_parameter("is_hidden", false)
		if animated_sprite != null: animated_sprite.material.set_shader_parameter("is_hidden", false)
		if Input.is_action_just_pressed("interact"):
			interacted()
	else: 
		if sprite != null: sprite.material.set_shader_parameter("is_hidden", true)
		if animated_sprite != null: animated_sprite.material.set_shader_parameter("is_hidden", true)

func interacted():
	Global.text_append("Interacted with " + str(name))
