extends Node2D

var is_opened = false
var has_red_gem = false
var has_blue_gem = false
var is_in_area = false



func _process(delta):
	if is_in_area:
		if Input.is_action_just_pressed("Interact"):
			if !has_red_gem and Global.items["red gem"]:
				has_red_gem = true
				$Sprite.frame = 2
			elif !has_blue_gem and Global.items["blue gem"]:
				has_blue_gem = true
				$Sprite.frame = 1
				
			if has_red_gem and has_blue_gem:
				Global.items["red gem"] = false
				Global.items["red gem"] = false
				Global.gates["completed puzzle 1"] = true
				$Sprite.frame = 3

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false
