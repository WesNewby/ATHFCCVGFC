extends KinematicBody2D

export var MOTION_SPEED = 100
export var DIRECTION = "down"
export var SCALE =Vector2(1,1)
export var HEALTH = 100
export var FRIEND = false #if true, does not damage player and can be interacted with
export var CAN_SHOOT = false

var RayNode
var collision 


func _ready():
	add_to_group("enemies")
	set_fixed_process(true)
	scale(SCALE)
	RayNode=get_node("RayCast2D")
	if(DIRECTION=="down"):
		RayNode.set_rotd(0)
	elif(DIRECTION=="up"):
		RayNode.set_rotd(180)
	elif(DIRECTION=="left"):
		RayNode.set_rotd(-90)
	elif(DIRECTION=="right"):
		RayNode.set_rotd(90)
	elif(DIRECTION=="up-right"):
		RayNode.set_rotd(135)
	elif(DIRECTION=="up-left"):
		RayNode.set_rotd(-135)
	elif(DIRECTION=="down-right"):
		RayNode.set_rotd(45)
	elif(DIRECTION=="down-left"):
		RayNode.set_rotd(-45)
	collision = false

func _fixed_process(delta):
	var motion = Vector2()

	if(is_colliding()):
		var collider = get_collider()
		if (collider.get_name()=="Player") :
			collider.hitByEnemy()
			move_func(motion, delta)
		else:
			reverse_on_collision()
			move_func(motion, delta)
	else :
		move_func(motion, delta)

func reverse_on_collision():
	if(DIRECTION=="down"):
		DIRECTION="up"
		RayNode.set_rotd(180)
	elif(DIRECTION=="up"):
		DIRECTION="down"
		RayNode.set_rotd(0)
	elif(DIRECTION=="left"):
		DIRECTION="right"
		RayNode.set_rotd(90)
	elif(DIRECTION=="right"):
		DIRECTION="left"
		RayNode.set_rotd(-90)
	elif(DIRECTION=="up-right"):
		DIRECTION="down-left"
		RayNode.set_rotd(-45)
	elif(DIRECTION=="up-left"):
		DIRECTION="down-right"
		RayNode.set_rotd(45)
	elif(DIRECTION=="down-right"):
		DIRECTION="up-left"
		RayNode.set_rotd(-135)
	elif(DIRECTION=="down-left"):
		DIRECTION="up-right"
		RayNode.set_rotd(135)

func move_func(motion, delta):
	if(DIRECTION=="down"):
		motion+=Vector2(0,1)
	elif(DIRECTION=="up"):
		motion+=Vector2(0,-1)
	elif(DIRECTION=="left"):
		motion+=Vector2(-1,0)
	elif(DIRECTION=="right"):
		motion+=Vector2(1,0)
	if(DIRECTION=="up-right"):
		motion+=Vector2(1,1)
	if(DIRECTION=="up-left"):
		motion+=Vector2(1,-1)
	if(DIRECTION=="down-right"):
		motion+=Vector2(-1,1)
	if(DIRECTION=="down-left"):
		motion+=Vector2(-1,-1)
		
	motion = motion.normalized()*MOTION_SPEED*delta
	move(motion)	

func damage(target) :
	