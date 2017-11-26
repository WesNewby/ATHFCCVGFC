extends KinematicBody2D

export var MOTION_SPEED = 0
export var DIRECTION = "left"
export var SCALE =Vector2(1,1)
#export var HEALTH = 100
export var WORDS = [" ","Every luxury has a deep price. Every indulgence, a cosmic cost.", "Each fiber of pleasure you experience causes equivalent pain somewhere else.", "This is the first law of emodynamics. Joy can be neither created nor destroyed. The balance of happiness is constant.","Fact: Every time you eat a bite of cake, someone gets horsewhipped. Facter: Every time two people kiss, an orphanage collapses.", "Factest: Every time a baby is born, an innocent animal is severely mocked for its physical appearance.", "Don't be a pleasure hog. Your every smile is a dagger. Happiness is murder. Vote 'yes' on Proposition 1321."]
export var WORDS1 = [" ", "Are we just fleshy blips in some meaningless stew of cosmic oblivion?"," ", "Is our every trollop through fate's garden infused with a mystic...", " ", "Do yourself a solid. Walk away. Just walk away.", " ", "Listen,this is never easy to say. You and I both knew what we had couldn't last. I do love you. But the love of my life is a lady named Ramblin' On."]
export var ACTIVE = false
export var dialog_time = 3.5

var timeLeft
var showing_dialog=false
var RayNode
var collision 
var dialog_bool = false
onready var dialog = get_node("Dialog")
var dialog_iterator = 0

func _ready():
	add_to_group("Xavier")
	timeLeft = dialog_time
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
	
	if(showing_dialog):
		timeLeft-=delta
		if(timeLeft<0):
			interate_dialog()
	
	var motion = Vector2()
	if(is_colliding()):
		var collider = get_collider()
		if (collider.get_name()=="Player") :
			pass
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

func get_active():
	return ACTIVE

func get_words():
	return WORDS

func activate_dialog():
	if(!showing_dialog):
		if (dialog_bool):
			WORDS=WORDS1
			dialog_time=3.5
		interate_dialog()
	

func interate_dialog():
	if(dialog_iterator>=WORDS.size()):
		dialog.hide()
		dialog_iterator=0
		timeLeft=dialog_time
		showing_dialog=false
	else:
		dialog.set_text(WORDS[dialog_iterator])
		dialog.show()
		timeLeft=dialog_time
		showing_dialog=true
		dialog_iterator+=1

func set_dialog_bool(arg):
	dialog_bool=arg