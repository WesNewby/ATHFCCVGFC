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
	if(id==1):
		set_animation("left")
	elif(id==2):
		set_animation("right")
	else:
		set_animation("idle")
	