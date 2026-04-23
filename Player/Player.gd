extends KinematicBody2D


var motion = Vector2()
var speed = 440
var run_speed = 640
var my_speed = speed


var message_to_display = ""
var messsage_builder = ""
var message_i = 0
var message_speed = 1
var message_counter = 0
var message_erase = 45


func _ready():
	Global.player = self
	
	
func _process(delta):
	
	# Used to display a message above the player
	
	#	If the message is not in the erase phrase, then it won't go away
	if message_to_display == "erase":
		if message_counter != message_erase:
			message_counter += 1
		else:
			message_to_display = ""
			message_i = 0
			message_counter = 0
			$LabelMessage.text = ""
			$LabelMessage.visible = false
	
	#	If the messsage to display is nothing in the string, then need to display the thing as the message
	elif message_to_display != "" :
		if message_counter == message_speed:
			messsage_builder += message_to_display[message_i]
			message_i += 1
			$LabelMessage.text = messsage_builder
			message_counter = 0
			if message_i + 1 == message_to_display.length() + 1:
				message_i = 0
				message_to_display = "erase"
				messsage_builder = ""
				message_counter = 0
		else:
			message_counter += 1
			
		
	
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
		
		
func display_message(message:String):
	message_to_display = message
	$LabelMessage.visible = true


func _on_Timer_timeout():
	messsage_builder += message_to_display[message_i]
	message_i += 1
	$LabelMessage.text = messsage_builder
	if message_i + 1 == message_to_display.length() + 1:
		$LabelMessage/Timer.stop()
		message_i = 0
		message_to_display = ""
		messsage_builder = ""
	
