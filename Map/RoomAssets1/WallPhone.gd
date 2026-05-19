extends Sprite

var in_area = false
var called = false
var message = ""


func _ready():
	pass
	
func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			var ps = load("res://InteractableItems/Phone.tscn").instance()
			$CanvasLayer.add_child(ps)
			pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
