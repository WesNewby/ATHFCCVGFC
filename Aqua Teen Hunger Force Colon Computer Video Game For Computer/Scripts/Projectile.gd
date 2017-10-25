extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var Speed = 10
var dir = Vector2(0,0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	add_to_group("bullets")

func _fixed_process(delta):
	
	var pos = self.get_pos()
	pos += Vector2(dir.angle() * Speed * delta, dir.angle() * Speed * delta)
	self.set_pos(pos)

func set_dir(a):
	dir=a
