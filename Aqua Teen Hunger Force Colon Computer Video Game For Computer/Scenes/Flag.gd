extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var pos
var down = true


func _ready():
	# Called every time the node is added to the scene.
	pos =get_global_pos()
	add_to_group("checkpoints")


func set_texture():
	if(down) :
		var sprite = get_node("Sprite")
		sprite.set_texture(load("res://Sprites/upflag.png.png"))
		down = false

func get_position():
	return pos