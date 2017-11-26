extends AnimatedSprite
var tempElapsed = 0


func _ready():
	set_process(true)
   
func _process(delta):
	tempElapsed = tempElapsed + delta
	if(tempElapsed > 0.3):
		setAnimation()
		if(get_frame() ==0):
			set_frame(1)
		else:
			set_frame(0)
		tempElapsed = 0

		
func setAnimation():
	var id =get_parent().getAnimationID() # 0=stationary, 1=left, 2=right, 3=up,4=down
	if(get_parent().get_popped()==true):
		set_scale(Vector2(.7,.7))
		set_pos(Vector2(-0.440125,-0.880249))
		if(id==0):
			set_animation("idle_rebirth")
		else:
			set_animation("move_rebirth")
	else: 
		if(id==0):
			set_animation("idle")
		else:
			set_animation("move")
