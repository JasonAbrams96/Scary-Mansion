extends KinematicBody2D


var motion = Vector2()
var speed = 24
var max_speed = 240
var run_speed = 48
var my_speed = speed



var message_to_display = ""
var displaying_message = false

var lbl_spot_left_face = Vector2(0, -104)
var lbl_spot_right_face = Vector2(-192, -104)
var y_changed = false


func get_input():
	
	if Input.is_action_just_pressed("Shift"):
		my_speed = run_speed
		max_speed *= 2
	elif Input.is_action_just_released("Shift"):
		my_speed = speed
		max_speed /= 2
		
	#If left is pressed
	if Input.is_action_pressed("Left"):
		if $Sprite.flip_h != true:
			$Sprite.flip_h = true
		if $LabelMessage.rect_position == lbl_spot_right_face:
			$LabelMessage.rect_position = lbl_spot_left_face
			
		#This blip changes the direction if there is already movement
		if motion.x > 0:
			motion.x *= -1
		motion.x -= my_speed
		
		if motion.x < -max_speed:
			motion.x = -max_speed
	
	#If Right is pressed
	elif Input.is_action_pressed("Right"):
		if $Sprite.flip_h != false:
			$Sprite.flip_h = false
		if $LabelMessage.rect_position == lbl_spot_left_face:
			$LabelMessage.rect_position = lbl_spot_right_face
			
		#This blip changes the direction if there is already movement
		if motion.x < 0:
			motion.x *= -1
		motion.x += my_speed
		if motion.x > max_speed:
			motion.x = max_speed
		
	else:
		#if the right or left is not pressed then slow down
		if motion.x < 0:
			motion.x += speed
		elif motion.x > 0:
			motion.x -= speed
		else:
			motion.x = 0
	
	
func _ready():
	Global.player = self
	
	
func _process(delta):
	if message_to_display != "" and !displaying_message:
		displaying_message = true
		$LabelMessage.text = message_to_display
		$LabelMessage/Timer.start()
		
			
			
func _physics_process(delta):
	get_input()
	if (motion.x > 0 or motion.x < 0):
		print("walk")
		if $Animator.current_animation != "Walk":
			$Animator.play("Walk")
	else:
		if $Animator.current_animation == "Walk":
			$Animator.play("Idle")
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

