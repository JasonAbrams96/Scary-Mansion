extends Sprite

var in_area = false
var message = ""

func change():
	if frame == 0:
		frame = 1
	elif frame == 1:
		frame = 0

func _ready():
	Global.connect("change_environment", self, "change")
	

func _process(delta):
	if in_area and Input.is_action_just_pressed("Interact"):
		message = "What a neat shower"
		Global.player.display_message(message)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
