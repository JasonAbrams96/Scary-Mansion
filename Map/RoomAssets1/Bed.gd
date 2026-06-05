extends Sprite


var in_area = false
var message = "What a lovely bed"
var item = null

func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			if item != null:
				#try give item (maybe make a global statement)
				pass
			else:
				Global.player.display_message(message)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
