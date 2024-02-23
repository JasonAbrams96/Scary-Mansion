extends Area2D




func _on_StaircaseD_body_entered(body):
	if body.is_in_group("player"):
		$ArrowSprite.visible = true
		$ArrowSprite/AnimationPlayer.play("ArrowMove")

func _on_StaircaseD_body_exited(body):
	if body.is_in_group("player"):
		$ArrowSprite.visible = false
		$ArrowSprite/AnimationPlayer.stop()
