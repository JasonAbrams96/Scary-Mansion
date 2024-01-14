extends Area2D

var player_in_area = false



func _on_Staircase_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		$Sprite2.visible = true
		$Sprite2/AnimationPlayer.play("Up")


func _on_Staircase_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
		$Sprite2/AnimationPlayer.stop()
		$Sprite2.visible = false
