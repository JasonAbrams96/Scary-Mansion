extends StaticBody2D

#Sprite Frame 0 is Wall
#Sprite Frame 1 is Door
#Sprite Frame 2 is Open

#multiples of those numbers would be the wall/door wall placements
var local = Vector2(784, 224)

var in_area = false
var is_locked = true
var message = "This door is locked, I need a key! TODO"

enum mode {WALL, DOOR, OPEN}
var curr_mode = mode.WALL

func _process(delta):
	if curr_mode == mode.OPEN:
		$Area2D.monitoring = false
		$Sprite.frame = 2
		set_process(false)
	elif curr_mode == mode.WALL:
		set_process(false)
		
	if in_area and curr_mode == mode.DOOR:
		if Input.is_action_just_pressed("Interact"):
			Global.player.display_message(message)
			#Check for a door key in hands TODO
			curr_mode = mode.OPEN
		


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
