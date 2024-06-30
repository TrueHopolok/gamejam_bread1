class_name Interactable extends Node2D

@export var is_interactable : bool = true

@onready var area_node : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D

func _ready():
	if area_node == null: 
		print(name + ": Area2D not added for this node as iteractable class")
		return
	if sprite == null: 
		print(name + ": Sprite2D not added for this node as iteractable class")
		return
	if sprite.material == null:
		print(name + ": Material not added for this node as iteractable class")
		return

func _process(_delta):
	if !Global.game_paused \
	&& is_interactable \
	&& len(area_node.get_overlapping_areas()) > 0:
		sprite.material.set_shader_parameter("is_hidden", false)
		if Input.is_action_just_pressed("interact"):
			interacted()
	else: 
		sprite.material.set_shader_parameter("is_hidden", true)

func interacted():
	Global.text_append("Interacted with " + str(name))
