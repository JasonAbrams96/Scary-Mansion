extends Node2D

func _ready():
	Global.connect("time_updated", self, "update_hand")
	
func update_hand():
	$SpriteClock/Hand.rotation_degrees = Global.current_min * 6
