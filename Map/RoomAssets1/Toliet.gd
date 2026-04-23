extends Sprite

var in_area = false

func _ready():
	pass
	

func _process(delta):
	if in_area and Input.is_action_just_pressed("Interact"):
		if Global.inventory_has_item("toliet knob"):
			var i = Global.inventory_remove_item("toliet knob", 1)
			

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	pass # Replace with function body.
