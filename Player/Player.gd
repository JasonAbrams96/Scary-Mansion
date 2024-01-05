extends KinematicBody2D


var motion = Vector2()
var speed = 640
var run_speed = 840
var my_speed = speed

func _ready():
	pass
	
	
func get_input():
	
	if Input.is_action_just_pressed("Shift"):
		my_speed = run_speed
	elif Input.is_action_just_released("Shift"):
		my_speed = speed
		
	#If left is pressed
	if Input.is_action_pressed("Left"):
		#This blip changes the direction if there is already movement
		if motion.x > 0:
			motion.x *= -1
		motion.x -= 20
		
		if motion.x < -my_speed:
			motion.x = -my_speed
	
	#If Right is pressed
	elif Input.is_action_pressed("Right"):
		#This blip changes the direction if there is already movement
		if motion.x < 0:
			motion.x *= -1
		motion.x += 20
		if motion.x > my_speed:
			motion.x = my_speed
		
	else:
		#if the right or left is not pressed then slow down
		if motion.x < 0:
			motion.x += 40
		elif motion.x > 0:
			motion.x -= 40
		else:
			motion.x = 0
			
			
func _physics_process(delta):
	get_input()
	
	motion = move_and_slide(motion)
		
