extends Sprite

var in_area = false
var has_knob = false
func _ready():
	pass
	
func _update_sprite():
	has_knob = true
	$".".frame = 0


func _process(delta):
	if in_area and Input.is_action_just_pressed("Interact"):
		if !has_knob:
			var k_id = GlobalItems.item_names["knob"]
			if Global.player_left_hand_item_id == k_id:
				Global.player.display_message("Knob Used")
				GlobalItems.emit_signal("update_hands", 1, null)
				_update_sprite()
			elif Global.player_right_hand_item_id == k_id:
				Global.player.display_message("Knob used")
				GlobalItems.emit_signal("update_hands", 0, null)
				_update_sprite()
			
		elif has_knob:
			Global.player.display_message("Flush weeeeeee")
			

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
