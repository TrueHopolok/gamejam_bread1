extends Sprite2D

@export var textures_of_items : Array[Texture] = \
[
	preload("res://textures/temp_square.png"),
	preload("res://textures/inventory/Bottle.png"),
	preload("res://textures/inventory/Bottle_Rose_1.png"),
	preload("res://textures/inventory/Firelighter_1.png"),
	preload("res://textures/inventory/Revolver_1.png"),
	preload("res://textures/inventory/Molotov_1.png"),
	preload("res://textures/inventory/Janitors_napkin1.png"),
]

func _process(_delta):
	visible = !clampi(Global.inventory_item, 0, len(textures_of_items)-1) == 0
	texture = textures_of_items \
	[
		clampi(Global.inventory_item, 0, len(textures_of_items)-1)
	]
