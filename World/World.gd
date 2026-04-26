extends Node

onready var the_camera = $Camera2D
var room_size = 784
var current_room_num = 0
var prev_room_num = 0
var next_room_num = 784
var room_size_y = 224
var prev_room_y_num = 0	
var next_room_y_num = 224



func _init():
	var gm = GenMap.new()
	

func _process(delta):
	if int($Player.global_position.x) > next_room_num:
		the_camera.position.x += room_size
		current_room_num += room_size
		prev_room_num += room_size
		next_room_num += room_size
	elif int($Player.global_position.x) < prev_room_num:
		the_camera.position.x -= room_size
		current_room_num -= room_size
		prev_room_num -= room_size
		next_room_num -= room_size
	
	if $Player.y_changed:
		
		if int($Player.global_position.y) > next_room_y_num :
			the_camera.position.y += room_size_y
			next_room_y_num += room_size_y
			prev_room_y_num += room_size_y
		elif int($Player.global_position.y) < next_room_y_num :
			the_camera.position.y -= room_size_y
			next_room_y_num -= room_size_y
			prev_room_y_num -= room_size_y
		$Player.y_changed = false
