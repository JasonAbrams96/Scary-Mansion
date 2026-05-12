extends Sprite

var in_area = false
var is_unlocked = false
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
				pass
			elif !is_unlocked:
				#Check hands for item needed
				#and use said item
				Global.player.display_message("Looks like a stone lock on this door.")



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
