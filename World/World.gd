extends Node

onready var the_camera = $Camera2D
var room_size = 784
var current_room_num = 0
var prev_room_num = 0
var next_room_num = 784

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
