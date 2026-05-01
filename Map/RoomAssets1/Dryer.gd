extends Sprite


var in_area = false
var has_item = false
var item = null
var message = ""


func set_item(it):
	item = it
	has_item = true


func _process(delta):
	if in_area and Input.is_action_just_pressed("Interact"):
		if has_item and item != null:
			message = "You found a " + item.my_name
		elif has_item and item == null:
			message = "You see nothing in the dryer."
		elif !has_item:
			message = "What a dryer."
			
		Global.player.display_message(message)
			
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
