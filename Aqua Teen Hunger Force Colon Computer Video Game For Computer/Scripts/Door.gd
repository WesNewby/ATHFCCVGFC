extends KinematicBody2D

export var DOOR_ID = 0
export var DOOR_TO_ID = 1
export var TEXTURE_CHANGE = false
export var NEEDS_KEY = false
export var KEY_OPENS = 0
var pos

func _ready():
	set_name("door"+str(DOOR_ID))
	if(TEXTURE_CHANGE!= false) :
		get_node("Sprite").set_texture(load("res://Sprites/door1.png"))
	pos = get_global_pos() +Vector2(0,64)
	add_to_group("doors")



func getNextDoorName():
	return ("door"+str(DOOR_TO_ID))

func getDoorName():
	return get_name()

func getPos():
	return pos
func use_key(has_key): 
	if(NEEDS_KEY&&DOOR_TO_ID!=KEY_OPENS&&has_key):
		DOOR_TO_ID = KEY_OPENS
		return true
	return false
