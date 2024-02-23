extends Node2D

var keyless_phrase = "Hmmmm, I don't seem to have the key for this door, it seems to be a [COLOR] door knob."
var player_in_area = false




func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		#Display text bubble
		
		

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
