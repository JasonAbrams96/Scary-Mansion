extends Sprite


var in_area = false
var sword_taken = false

func _process(delta):
	if in_area:
		if !sword_taken:
			#try to add to inventory
			Global.player.display_message("I have gotten the sword of Faith")
			sword_taken = true
			frame = 1 


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
