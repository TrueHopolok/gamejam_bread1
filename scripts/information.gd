class_name GameInfo

var started : bool
var drink_ordered : bool
var talked_with_target : bool
var flooded : bool
var agro_bottle_broken : bool
var cleaner_cleaning : bool
var is_loudly : bool
var agro_music : bool

func _init():
	agro_music = false
	is_loudly = false
	cleaner_cleaning = true
	agro_bottle_broken = false
	flooded = false
	talked_with_target = false
	drink_ordered = false
	started = false

