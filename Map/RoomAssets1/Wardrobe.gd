extends Sprite

var in_area = false
var item = null
var message = ""

func _update():
	frame = 1
	
func _ready():
	Global.connect("change_environment", self, "_update")
	
func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			if item != null:
				#Try give item to player
				pass
			else:
				Global.player.display_message(name)


func _on_Area2D_body_entered(body):
		if body.is_in_group("player"):
			in_area = true

func _on_Area2D_body_exited(body):
		if body.is_in_group("player"):
			in_area = false
