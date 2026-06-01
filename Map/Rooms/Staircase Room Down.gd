extends Node2D

export var room:NodePath
var can_go_down = false
var player = null
onready var my_pos = $Position2D.global_position

export var is_debug = false

func remove_left_room_wall():
	$RoomWalls/Left.queue_free()

func remove_right_room_wall():
	$RoomWalls/Right.queue_free()


func _ready():
	if is_debug:
		remove_left_room_wall()
		remove_right_room_wall()

func _on_AreaDown_body_entered(body):
	if body:
		if body.is_in_group("player"):
			player = body
			can_go_down = true

func _on_AreaDown_body_exited(body):
	if body:
		if body.is_in_group("player"):
			player = null
			can_go_down = false
			
func _process(delta):
	if can_go_down:
		if Input.is_action_just_pressed("Interact"):
			player.global_position = get_node(room).my_pos
			player.y_changed = true
