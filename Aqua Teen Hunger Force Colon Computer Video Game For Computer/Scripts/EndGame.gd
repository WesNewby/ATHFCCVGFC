extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	get_node("sounds").play("Mystic")
	


func _on_End_It_pressed():
	get_tree().quit()


func _on_Restart_pressed():
	get_tree().change_scene("res://Scenes/World.xml")
