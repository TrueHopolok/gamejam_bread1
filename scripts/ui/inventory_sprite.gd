extends Sprite2D

@export var textures_of_items : Array[Texture] = \
[
	preload("res://textures/temp_square.png")
]

func _process(_delta):
	texture = textures_of_items \
	[
		clampi(Global.inventory_item, 0, len(textures_of_items)-1)
	]
