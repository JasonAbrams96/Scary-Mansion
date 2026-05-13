extends Sprite

var item_inside = null
var in_area = false
var message = ""

func damage():
	frame = 1

func _ready():
	Global.connect("change_environment", self, "damage")
	pass
	
func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			if item_inside == null:
				Global.player.display_message("What a fine china cabinet.")
			else:
				Global.player.display_message("An Item!")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
