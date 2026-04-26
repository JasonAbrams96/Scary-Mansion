extends KinematicBody2D


var motion = Vector2()
var speed = 440
var run_speed = 640
var my_speed = speed


var message_to_display = ""
var displaying_message = false

var y_changed = false

func _ready():
	Global.player = self
	
	
func _process(delta):
	if message_to_display != "" and !displaying_message:
		displaying_message = true
		$LabelMessage.text = message_to_display
		$LabelMessage/Timer.start()
		
	
func get_input():
	
	if Input.is_action_just_pressed("Shift"):
		my_speed = run_speed
	elif Input.is_action_just_released("Shift"):
		my_speed = speed
		
	#If left is pressed
	if Input.is_action_pressed("Left"):
		if $Sprite.flip_h != true:
			$Sprite.flip_h = true
			
		#This blip changes the direction if there is already movement
		if motion.x > 0:
			motion.x *= -1
		motion.x -= 20
		
		if motion.x < -my_speed:
			motion.x = -my_speed
	
	#If Right is pressed
	elif Input.is_action_pressed("Right"):
		if $Sprite.flip_h != false:
			$Sprite.flip_h = false
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
		

#Is used to set the message to display
func display_message(message:String):
	message_to_display = message
	$LabelMessage.visible = true




func _on_Timer_timeout():
	$LabelMessage.text = ""
	message_to_display = ""
	displaying_message = false
	$LabelMessage.visible = false

