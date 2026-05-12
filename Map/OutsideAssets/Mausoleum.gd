extends Sprite

var in_area = false
var is_unlocked = false
var scene_to_load = "res://Map/InsideRooms/InsideMausoleum.tscn"
var item_needed = null

func _ready():
	item_needed = GlobalItems.items_names["stone key"]
	if item_needed == null:
		push_error(name + " item needed is null")
		
func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			if is_unlocked:
				#Go into mausoleum
				#Fade into scene
				Global.world_stack.push_back(get_tree().current_scene)
				Global.player_pos_for_world_stack.push_back(Global.player.global_position)
				get_tree().change_scene(scene_to_load)
				pass
			elif !is_unlocked:
				#Check hands for item needed
				#and use said item
				Global.player.display_message("Looks like a stone lock on this door.")
				is_unlocked = true



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
