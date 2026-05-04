extends Node2D


#NOTE

#		Update so wall is one sprite. To make it look less dumb tbh
#		Make it so clouds go behind Rooms in house

var speed = 50
onready var clouds = get_children()

var next = null
var next_count = 0
var start_pos = 0
var width = 112
var max_pos = 784

func _process(delta):
	if next == null:
		next = clouds[next_count]
		
	for i in range(clouds.size()):
		clouds[i].global_position.x -= speed * delta
		
	if next.position.x <= -width:
		next.position.x = max_pos
		
		next_count += 1
		if next_count >= 8:
			next_count = 0
			
		next = clouds[next_count]
		
		
	
		
	
