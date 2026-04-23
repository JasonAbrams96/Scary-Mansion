extends Area2D

var stair_room

func _on_Staircase_body_entered(body):
	if body.is_in_group("player"):
		$Sprite2.visible = true
		$Sprite2/AnimationPlayer.play("Up")


func _on_Staircase_body_exited(body):
	if body.is_in_group("player"):
		$Sprite2/AnimationPlayer.stop()
		$Sprite2.visible = false
