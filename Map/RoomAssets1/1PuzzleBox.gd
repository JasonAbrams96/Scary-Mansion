extends Node2D

var is_opened = false
var has_red_gem = false
var has_blue_gem = false
var is_in_area = false

var contents = null


func _process(delta):
	if is_in_area:
		if Input.is_action_just_pressed("Interact"):
			if !has_red_gem and _check_gem("red gem"):
				var temp = Global.inventory_remove_item("red gem", 1)
				temp = null
				has_red_gem = true
				$Sprite.frame = 2
			elif !has_blue_gem and _check_gem("blue gem"):
				Global.inventory_remove_item("blue gem", 1);
				has_blue_gem = true
				$Sprite.frame = 1
				
			if has_red_gem and has_blue_gem:
				$Sprite.frame = 3
				is_opened = true
				
				if is_opened:
					if Global.inventory_add_item_by_id(contents.my_id):
						#Display message that it added TODO
						pass
					else:
						#Display message that it did not add
						pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		is_in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		is_in_area = false

func _check_gem(gem_name):
	gem_name = gem_name.to_lower()
	
	var Gl = -1
	
	if !GlobalItems.items_names.has(gem_name):
		return false
	elif GlobalItems.items_names.has(gem_name):
		Gl = GlobalItems.items_names[gem_name]
		if Gl == Global.player_right_hand_item_id:
			GlobalItems.emit_signal("update_hands", 0, null)
			return true
		elif Gl == Global.player_left_hand_item_id:
			GlobalItems.emit_signal("update_hands", 1, null)
			return true
		else:
			return false
