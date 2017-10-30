extends AnimatedSprite

var tempElapsed = 0


func _ready():
	set_process(true)
   
func _process(delta):
	tempElapsed = tempElapsed + delta
	if(tempElapsed > 0.3):
		if(get_frame() ==0):
			set_frame(1)
		else:
			set_frame(0)
		tempElapsed = 0