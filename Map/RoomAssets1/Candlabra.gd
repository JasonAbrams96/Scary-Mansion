extends Node2D

var amount_needed = 3
var player_in_area = false
onready var item_to_look_for = GlobalItems.items[6]

func _on_Area2D_body_exited(body):
	player_in_area = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true


func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("Interact"):
			if Global.inventory.has(item_to_look_for):
				var item = Global.inventory[item_to_look_for]
				if item.amount_in_stack >= amount_needed:
					item.amount_in_stack -= amount_needed
					Global.inventory_update()
