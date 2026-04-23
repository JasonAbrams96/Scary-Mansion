extends Node

onready var item_spots = $Sprite/Item_Spots.get_children()

#	ready sets the item screen
func _ready():
	Global.player_has_control = false
	Global.enemies_have_control = false
	#Sets the description area to be assigned a description
	Global.item_description_label = $Sprite/DescriptionPanel
	
	
	var inven = Global.inventory
	# If inven item slot is not set, then set it
	for i in range(inven.size()):
		if inven[i].item_slot_local == -1:
			for j in range(item_spots.size()):
				if !item_spots[j].is_taken:
					inven[i].item_slot_local = j
					item_spots[j].set_item_pic(inven[i])
					item_spots[j].set_item_num(inven[i])
					item_spots[j].set_inventory_slot_number(i)
					item_spots[j].is_taken = true
					break
		elif inven[i].item_slot_local == -10:
			#Is in right hand
			$Sprite/Right_Spot/Item.set_item_num(inven[i])
			$Sprite/Right_Spot/Item.set_item_pic(inven[i])
			$Sprite/Right_Spot/Item.set_inventory_slot_number(i)
			$Sprite/Right_Spot/Item.is_taken = true
		elif inven[i].item_slot_local == -11:
			#Is in left hand
			$Sprite/Left_Spot/Item.set_item_num(inven[i])
			$Sprite/Left_Spot/Item.set_item_pic(inven[i])
			$Sprite/Left_Spot/Item.set_inventory_slot_number(i)
			$Sprite/Left_Spot/Item.is_taken = true
		# Else then set the correct item slot with the correct item
		else:
			item_spots[inven[i].item_slot_local].set_item_pic(inven[i])
			item_spots[inven[i].item_slot_local].set_item_num(inven[i])
			item_spots[inven[i].item_slot_local].set_inventory_slot_number(i)
			item_spots[inven[i].item_slot_local].is_taken = true
		
		# To display items in stack or not
		if inven[i].item_slot_local == -10 and inven[i].stack_max != 0:
			$Sprite/Right_Spot/Item.toggle_label_visibility()
			$Sprite/Right_Spot/Item.set_amount_label(inven[i].amount_in_stack, inven[i].stack_max)
		elif inven[i].item_slot_local == -11 and inven[i].stack_max != 0:
			$Sprite/Left_Spot/Item.toggle_label_visibility()
			$Sprite/Left_Spot/Item.set_amount_label(inven[i].amount_in_stack, inven[i].stack_max)
		elif inven[i].stack_max != 0:
			item_spots[inven[i].item_slot_local].toggle_label_visibility()
			item_spots[inven[i].item_slot_local].set_amount_label(inven[i].amount_in_stack, inven[i].stack_max)


func _process(delta):
	if Input.is_action_just_pressed("Pause_Escape"):
		Global.player_has_control = true
		Global.enemies_have_control = true
		close()


func close():
	Global.emit_signal("gui_inventory_closed")
	Global.player_has_control = true
	Global.enemies_have_control = true
	Global.inventory_open = false
	queue_free()
	
	
func update_inventory_slot_ids():
	var inven = Global.inventory
	var i_spots = $Sprite/Item_Spots.get_children()
	for i in range(inven.size()):
		for j in range(i_spots.size() -1): # minus 1 because temp control gets addded to the end for a preview texture that you are moving
			if inven[i].id_no == i_spots[j].item_num:
				inven[i].item_slot_local = j
				
#Frees the inventory screen from the shackles of this world
func _on_Button_pressed():
	close()
