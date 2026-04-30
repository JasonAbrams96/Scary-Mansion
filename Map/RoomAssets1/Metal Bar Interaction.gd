extends Area2D


var is_inserted = false
var interacting = false

var room = null
export var number:int = 0
var message = ""
var in_area = false


func _update_sprite():
	$Sprite.frame_coords.x += 1
	is_inserted = true
	
func _ready():
	if number == 1:
		$Sprite.frame_coords = Vector2(0, 1)
	elif number == 2:
		$Sprite.frame_coords = Vector2(0, 2)
	elif number == 3:
		$Sprite.frame_coords = Vector2(0, 3)
		
	

func _process(delta):
	if in_area and Input.is_action_just_pressed("Interact") and !interacting:
		interacting = !interacting
		Global.player.display_message("You interacted with a metal breaker box")
		var metal_bar_id = GlobalItems.items_names["metal bar"]
		if Global.player_left_hand_item_id == metal_bar_id and !is_inserted:
			GlobalItems.emit_signal("update_hands", 1, null, Global.player_left_hand_item_inventory_local)
			_update_sprite()
			room.toggle_light()
		elif  Global.player_right_hand_item_id == metal_bar_id and !is_inserted:
			GlobalItems.emit_signal("update_hands", 0, null, Global.player_right_hand_item_inventory_local)
			_update_sprite()
			room.toggle_light()
		interacting = !interacting
				
		


func _on_MetalBarInsert_body_entered(body):
	if body.is_in_group("player"):
		in_area = true
		

func _on_MetalBarInsert_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
