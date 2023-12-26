extends Area2D


var is_inserted = false
export var connected_light = false

func _process(delta):
	if Input.is_action_just_pressed("Interact"):
		if Global.items["metal bar"] and !is_inserted:
			Global.items["metal bar"] = false
			Global.emit_signal("item_used", "metal bar")
		elif !Global.items["metal bar"] and is_inserted:
			Global.items["metal bar"] = true
			Global.emit_signal("item_got", "metal bar")
			
