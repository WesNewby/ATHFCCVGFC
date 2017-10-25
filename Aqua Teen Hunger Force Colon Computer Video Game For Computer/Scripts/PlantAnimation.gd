extends AnimatedSprite

var tempElapsed = 0
var frameID

func _ready():
	set_process(true)
	
   
func _process(delta):
	tempElapsed = tempElapsed + delta
	if(tempElapsed > 0.3):
		frameID = get_frame()
		if(get_frame() ==6):
			set_frame(0)
		else:
			set_frame(frameID+1)
		tempElapsed = 0
