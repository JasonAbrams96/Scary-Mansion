extends Sprite

var in_area = false
var message = ""

func update():
	frame = 1
	message = "Hmmmm...there is an interesting phrase: # 2cary VI"


func _ready():
	Global.connect("change_environment", self, "update")
	message = "Look at all those magnets on this fridge"
	

func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			Global.player.display_message("What a messy fridge. Why are there always the number magnets on them.")
			update()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
