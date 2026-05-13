extends Sprite

var in_area = false
var item_needed = false
var message = ""

func damage():
	frame = 1
	
func _ready():
	pass
	
func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			if item_needed == null:
				Global.player.display_message("Hmmm, what an oven.");
			else:
				#Check for player inventory
				Global.player.display_message("Got Item!")
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
