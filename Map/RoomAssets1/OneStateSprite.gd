extends Sprite

class_name OneState

var is_opened = false
var is_player_in_area = false

onready var contents = null
var _item_cant_be_added_message = ""

func _ready():
	
	set_contents(null)
	_item_cant_be_added_message = "%s, cannot be added to the bag, inventory full" % contents.my_name
	
func open():
	if is_player_in_area and player_hands_checked():
		is_opened = true
		$".".frame = 1
		return contents
	return null
	
func set_contents(item):
	if item == null:
		var rnd_item = GlobalItems.items[Global.rng.randi() % GlobalItems.items.size()].duplicate()
		contents = rnd_item
	else:
		contents = item
		
func player_hands_checked():
	if (Global.player_left_hand_item_id == GlobalItems.items_names["crowbar"]):
		return true
		
	elif (Global.player_right_hand_item_id == GlobalItems.items_names["crowbar"]):
		return true
	else:
		Global.player.display_message("I need some sort of tool to open this.")
		return false

func _process(delta):
	if Input.is_action_just_pressed("Interact") and is_player_in_area and !is_opened:
		if open() != null:
			if !Global.inventory_add_item_by_id(contents.id_no):
				Global.player.display_message(_item_cant_be_added_message)
			else:
				Global.player.display_message("%s, was added to my bag!" % contents.my_name)
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and !is_opened:
		is_player_in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		is_player_in_area = false
