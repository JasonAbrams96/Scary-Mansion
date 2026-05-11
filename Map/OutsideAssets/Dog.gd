extends Node2D

var max_speed = 3500 #tieing speed to delta later on
var direction = -1

var motion = Vector2()
var body
var sprite
var fed = false
enum state {PATROLLING, BARKING, ATTACK, FED}
var current_state = state.PATROLLING
var in_area = false

func _ready():
	body = $KinematicBody2D
	sprite = $KinematicBody2D/Sprite

func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			Global.player.display_message("I gave the dog the bone")
			current_state = state.FED
			#check hands for bone item
			#If has bone item, give to dog and update bowl too

func _physics_process(delta):
	
	#What the Dog do when it is patrolling
	if current_state == state.PATROLLING:
		motion.x = max_speed * delta * direction

		
		body.move_and_slide(motion)
		
		if body.position.x < $Position2D.position.x:
			direction = 1
			sprite.flip_h = true
		elif body.position.x > $Position2D2.position.x:
			direction = -1
			sprite.flip_h = false
	elif current_state == state.BARKING:
		sprite.flip_h = false
		#Barks at player to "Warn" them
		pass
	elif current_state == state.FED:
		if body.position.x < 0:
			motion.x = (max_speed - 1000) * delta
		elif body.position.x > 0:
			motion.x = (max_speed - 1000) * delta * -1
			
		body.move_and_slide(motion)
		
		if abs(body.position.x) < 1:
			Global.emit_signal("dog_to_house")
			queue_free()
		# Goes back to dog house and changes the doghouse sprite to reflect the dog has entered it and fell asleep
		#	queue_frees self
		pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if current_state != state.FED:
			current_state = state.BARKING
			sprite.flip_h = false
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		if current_state != state.FED:
			current_state = state.PATROLLING
		in_area = false
