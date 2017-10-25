extends KinematicBody2D

export var DOOR_ID = 0
export var DOOR_TO_ID = 1
var pos = get_global_pos()

func _ready():
	set_name("door"+str(DOOR_ID))
	add_to_group("enemies")



func getNextDoorName():
	return ("door"+str(DOOR_TO_ID))

func getDoorName():
	return get_name()

func getPos():
	return pos