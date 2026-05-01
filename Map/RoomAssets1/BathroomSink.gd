extends Sprite

var locked = false
var in_area = false
var item_to_give_id= -1
var message = ""
var item_name_to_unlock = ""

func _ready():
	Global.connect("change_environment", self, "change")

func set_item(item_id):
	item_to_give_id = item_id

func change(is_damaged):
	# 0 with 3, 1 with 2
	if is_damaged:
		if frame == 0:
			frame = 3
		elif frame == 1:
			frame = 2
	else:
		if frame == 3:
			frame = 0
		elif frame == 2:
			frame = 1
	
	
func _Area2D_on_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _Area2D_on_body_exited(body):
	if body.is_in_group("player"):
		in_area = false


func _process(delta):
	
	if in_area and Input.is_action_just_pressed("Interact"):
		if locked and item_name_to_unlock != "" :
			#check for key in hands
			var i_id = GlobalItems.items_names[item_name_to_unlock]
			if i_id == Global.player_left_hand_item_id:
				pass
			elif i_id == Global.player_right_hand_item_id:
				pass
			
		else:
			message = "There is nothing under the sink."
