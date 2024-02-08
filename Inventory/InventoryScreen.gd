extends Node

onready var item_spots = $Sprite/Item_Spots.get_children()
func _ready():
	var inven = Global.inventory
	# If inven item slot is not set, then set it
	for i in range(inven.size()):
		if inven[i].item_slot_local == -1:
			inven[i].item_slot_local = i
			item_spots[i].set_item_pic(inven[i])
			
		# Else then set the correct item slot with the correct item
		else:
			item_spots[inven[i].item_slot_local].set_item_pic(inven[i])
		
		# To display items in stack or not
		if inven[i].stack_max != 0:
			item_spots[inven[i].item_slot_local].toggle_label_visibility()
			item_spots[inven[i].item_slot_local].set_amount_label(inven[i].amount_in_stack, inven[i].stack_max)



func _on_Button_pressed():
	Global.emit_signal("gui_inventory_closed")
	queue_free()
