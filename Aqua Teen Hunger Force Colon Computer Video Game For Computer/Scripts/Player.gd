extends KinematicBody2D

export var MOTION_SPEED = 140
export var HEALTH = 100
var RayNode
var laserCount = 0
var projectile = preload("res://Scenes/Projectile.xml")
var pressed = false
var lastMoveTime
var startTime
var start_pos
signal door

func _ready():
	set_name("Player")
	set_fixed_process(true)
	RayNode=get_node("RayCast2D")
	startTime= OS.get_unix_time()
	lastMoveTime = 0
	start_pos = get_global_pos()

func _fixed_process(delta):

	
	if Input.is_action_pressed("interact"):
		"""
		if pressed == false:
			fire(RayNode.get_cast_to())
			pressed = true
		else:
			pressed = false
			"""
	else:
		if(is_colliding()):
			var collider = get_collider()
			if (collider.is_in_group("enemies")) :
				set_global_pos(start_pos)
			elif (collider.is_in_group("doors")) :
				print("look")
				var x =get_tree().get_root().find_node(collider.getNextNodeName(), true, false)
				
				set_global_pos(x.getPos())
			elif (collider.is_in_group("flag")) :
				#set flag sprite up
				pass
		#motion
		var motion = Vector2()
		if(Input.is_action_pressed("ui_up")):
			motion+=Vector2(0,-1)
			RayNode.set_rotd(180)
			lastMoveTime=OS.get_unix_time()
		
		if(Input.is_action_pressed("ui_down")):
			motion+=Vector2(0,1)
			RayNode.set_rotd(0)
			lastMoveTime=OS.get_unix_time()
		
		if(Input.is_action_pressed("ui_left")):
			motion+=Vector2(-1,0)
			RayNode.set_rotd(-90)
			lastMoveTime=OS.get_unix_time()
		
		if(Input.is_action_pressed("ui_right")):
			motion+=Vector2(1,0)
			RayNode.set_rotd(90)
			lastMoveTime=OS.get_unix_time()
		
		motion = motion.normalized()*MOTION_SPEED*delta
		move(motion)
	
func fire(vector):
	var bullet_instance = projectile.instance()
	bullet_instance.set_dir(vector)
	bullet_instance.set_name("laser"+str(laserCount))
	add_child(bullet_instance)
	var laserPos = self.get_global_pos()
	get_node("laser"+str(laserCount)).set_global_pos(laserPos)
	laserCount = laserCount + 1

func getAnimationID():
	#0 = idle
	#1 = left
	#2 = right
	if(OS.get_unix_time()-lastMoveTime>0):
		return 0
	if(RayNode.get_rotd()==-90):
		return 1
	if(RayNode.get_rotd()==90):
		return 2
	return 0;

func hitByEnemy():
	set_global_pos(start_pos)


func changeHealth(value) : #adds the value (positive or negative) to player health. kills player if result <0
	HEALTH+=value
	if(HEALTH==100):
		print("Max health!")
	elif(HEALTH>100):
		if(HEALTH>150):
			HEALTH=150
		print("Super Charged health! +", value)
	elif(HEALTH<=0) :
		die()
		return 
	else :
		if(value>0) :
			print("gained health! +",value)
		else :
			print("took damage! -",value)
	updateHealthBar()

func die() :
	pass
	#death

