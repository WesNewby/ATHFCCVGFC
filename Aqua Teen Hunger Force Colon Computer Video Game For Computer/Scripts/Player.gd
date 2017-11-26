extends KinematicBody2D

export var MOTION_SPEED = 140
export var start_pos = 0

#dialog exports
export var WORDS = [" "]
export var WORDS1 = ["That's it! I give up! I sacrificed everything - even your lives - for you people, and what do I get?!", " ", "I'll just fit in. Take on a normal life! Meet a nice job; hold down a well paying family!", "Now clutch the dark purple hairs of the galloping orangutan of normalcy and ride! ride!"]
export var dialog_time = 3.5

var RayNode
var laserCount = 0
var projectile = preload("res://Scenes/Projectile.xml")
var pressed = false
var lastMoveTime
var startTime

signal door
var popped = false

var has_key = false

#dialog vars
var dialog_array 
var dialog_bool = false
onready var dialog = get_node("Dialog")
var dialog_iterator = 0
var timeLeft
var showing_dialog=false
var popped_dialog = ["Hot dang, I'm cured!"]
var xavier_two_dialog = ["What doth life?", " ", "Or is it vice-reversa?", " ", "Hey! I don't want no trouble, mister.", " ", "I have no powers. I mean, unless you count the power to blow minds with my weapons-grade philosophical insights.", " ", "So maybe we are just blips in a void of nothingness. And now it's time for me to walk away." ]
var xavier_response = [" ", "Are we just fleshy blips in some meaningless stew of cosmic oblivion?"," ", "Is our every trollop through fate's garden infused with a mystic...", " ", "Do yourself a solid. Walk away. Just walk away.", " ", "Listen,this is never easy to say. You and I both knew what we had couldn't last. I do love you. But the love of my life is a lady named Ramblin' On."]

func _ready():
	add_to_group("Player")
	set_name("Player")
	set_fixed_process(true)
	RayNode=get_node("RayCast2D")
	startTime= OS.get_unix_time()
	lastMoveTime = 0
	timeLeft = dialog_time
	dialog_array = WORDS
	start_pos = get_global_pos()
	
	

func _fixed_process(delta):
	if(showing_dialog):
		timeLeft-=delta
	if(timeLeft<0):
		interate_dialog()
		
	if(is_colliding()):
		var collider = get_collider()
		if (collider.is_in_group("enemies")) :
			get_node("sounds").play("POP SOUND EFFECT FREE NO COPYRIGHTS ROYALTY FREE")
			#popped = true
			print("popped")
			set_global_pos(start_pos)
		elif (collider.is_in_group("doors")) :
			if(collider.use_key(has_key)):
				set_key(false)
			var newPos =get_tree().get_root().find_node(collider.getNextDoorName(), true, false).getPos()
			set_global_pos(newPos)
		elif (collider.is_in_group("mooninites")):
			if(collider.get_active()):
				get_node("sounds").play("POP SOUND EFFECT FREE NO COPYRIGHTS ROYALTY FREE")
				#popped = true
				print("popped")
				set_global_pos(start_pos)
			else:
				var x = 0
				if(collider.has_key()):
					set_key(true)
					x=1
					set_dialog_bool(true)
				set_response(x, collider.get_response(x))
				activate_dialog(x)
				collider.activate_dialog(x)
		elif (collider.is_in_group("checkpoints")) :
			collider.set_texture()
			set_start_pos(collider.get_global_pos())
		elif (collider.is_in_group("Xavier")) :
			if(collider.get_active()):
				get_node("sounds").play("Mystic")
				set_dialog_bool(true)
				activate_dialog(2)
				collider.set_dialog_bool(true)
				collider.activate_dialog()
			else:
				set_response(0, ["You got a license to sell hot dogs, chico man?", " "])
				activate_dialog(0)
				collider.activate_dialog()
		elif (collider.is_in_group("level_one_end")) :
			get_tree().change_scene("res://Scenes/World2.xml")
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

func set_start_pos(position):
	start_pos=position

func get_popped():
	return popped
	
func set_popped(val):
	popped = val

func interate_dialog():
	if(dialog_iterator>=dialog_array.size()):
		dialog.hide()
		dialog_iterator=0
		timeLeft=dialog_time
		showing_dialog=false
		if(dialog_bool&&!popped):
			set_popped(true)
			activate_dialog(-1)
		elif(dialog_bool):
			get_tree().change_scene("res://Scenes/EndGame.xml")
		
	else:
		dialog.set_text(dialog_array[dialog_iterator])
		dialog.show()
		timeLeft=dialog_time
		if(dialog_bool&&dialog_iterator>=dialog_array.size()-1&&!popped):
			timeLeft=dialog_time -.5
		showing_dialog=true
		dialog_iterator+=1

func activate_dialog(arg):
	if(!showing_dialog):
		if(arg == -1):
			dialog_array = popped_dialog
			set_dialog_bool(false)
		elif(arg == 0):
			dialog_array = WORDS
		elif(arg == 1):
			dialog_array = WORDS1
		elif(arg==2):
			dialog_array = xavier_two_dialog
		interate_dialog()
		
func set_key(arg):
	has_key = arg

func set_dialog_bool(arg):
	dialog_bool=arg

func set_response(arg, text):
	if (arg==1):
		WORDS1 = text
	elif (arg==0):
		WORDS = text