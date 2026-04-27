extends Sprite

var in_area = false
var has_knob = false
func _ready():
	pass
	

func _process(delta):
	if in_area and Input.is_action_just_pressed("Interact"):
		if !has_knob and Global.inventory_has_item("toliet knob"):
			var i = Global.inventory_remove_item("toliet knob", 1)
			has_knob = true
			
		if has_knob:
			Global.
			

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
