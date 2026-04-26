extends Node2D

export var room:NodePath
var can_go_up = false
var player = null
onready var my_pos = $Position2D.global_position

func _on_AreaUp_body_entered(body):
	if body:
		if body.is_in_group("player"):
			player = body
			can_go_up = true
			
			
func _process(delta):
	if can_go_up:
		if Input.is_action_just_pressed("Interact"):
			#Go to room above
			player.global_position = get_node(room).my_pos
			player.y_changed = true


func _on_AreaUp_body_exited(body):
	if body:
		if body.is_in_group("player"):
			player = null
			can_go_up = false
