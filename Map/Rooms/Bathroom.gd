extends Node2D


export var is_debug = false

func remove_left_room_wall():
	$RoomWalls/Left.queue_free()

func remove_right_room_wall():
	$RoomWalls/Right.queue_free()


func _ready():
	if is_debug:
		remove_left_room_wall()
		remove_right_room_wall()
		remove_right_room_wall()
