extends TextureRect

signal visibilty_of_stack()

func can_drop_data(position, data):
	
	#Suprisingly easier than I thought, which is scary
	var m_pos = get_global_mouse_position()
	
	if self.texture != null:
		if data['item spot'].is_left_hand:
			GlobalItems.emit_signal("update_hands", 1, data['origin texture'])
		elif data['item spot'].is_right_hand:
			GlobalItems.emit_signal("update_hands", 0, data['origin texture'])
		return false
#	elif self.texture == data['origin texture']:
#		print("textures are the same")
#		return false
	else:
		return true
	
func get_drag_data(position):
	if texture != null:
		var data = {}
		data['origin texture'] = texture
		data['prev spot'] = self
		data['item amount label'] = get_child(0)	#Used to set text of label
		data['item spot'] = get_parent().get_parent() #Can access item_num and slot_num and inventory_slot_number variables
		data['is hand spot'] = false
#
		#Sets a texture while dragging the mouse
		var drag_text = TextureRect.new()
		drag_text.expand = true
		drag_text.texture = texture
		drag_text.rect_size = Vector2(28, 28)
#
		#Sets the texture on a control with an offset
		var control = Control.new()
		control.name = "temp control"
		control.add_child(drag_text)
		drag_text.rect_position = -0.5 * drag_text.rect_size
		set_drag_preview(control)

		return data
	
func drop_data(position, data):
	#This is the one that the item is being dropped into
	var item_deleted = false
	var my_p = get_parent().get_parent()
	texture = data['origin texture']
	data['prev spot'].texture = null
	
	data['item spot'].is_taken = false
	my_p.item_num = data['item spot'].item_num
	
	#Checking if the current is a hand spot or not
	if my_p.is_left_hand or my_p.is_right_hand:
		if my_p.is_left_hand:
			Global.player_left_hand_item_id = data['item spot'].item_num
			GlobalItems.emit_signal("update_hands", 1, texture)
			Global.inventory[data['item spot'].inventory_slot_number].item_slot_local = -11
			
			if data['item spot'].is_right_hand: # This is set the prev spot texture to no pic when moving
				#	from left to right hand in the GUI
				GlobalItems.emit_signal("update_hands", 0, null)
		elif my_p.is_right_hand:
			Global.player_right_hand_item_id = data['item spot'].item_num
			GlobalItems.emit_signal("update_hands", 0, texture)
			Global.inventory[data['item spot'].inventory_slot_number].item_slot_local = -10
			if data['item spot'].is_left_hand:	#This is set the prev spot texture to no pic when moving
				#	from right to left hand in the GUI
				GlobalItems.emit_signal("update_hands", 1, null)
				
	else:
		#This is for when the player moves an item from their hand slot to their inventory, to update
		#	the GUI hand spaces
		if data['item spot'].is_left_hand:
			Global.player_left_hand_item_id = -1
			GlobalItems.emit_signal("update_hands", 1, null)
			Global.inventory[data['item spot'].inventory_slot_number].item_slot_local = my_p.slot_num
		elif data['item spot'].is_right_hand:
			Global.player_right_hand_item_id = -1
			GlobalItems.emit_signal("update_hands", 0, null)
			Global.inventory[data['item spot'].inventory_slot_number].item_slot_local = my_p.slot_num
			
		elif my_p.is_trash_slot:
			Global.inventory_delete_item(data['item spot'].inventory_slot_number)
			texture = null
			my_p.item_num = -1
			get_parent().get_parent().get_parent().get_parent().get_parent().update_inventory_slot_ids()
			item_deleted = true
		else:
			print("inventory_slot_number: ", data['item spot'].inventory_slot_number)
			print("item_slot_local: ", Global.inventory[data['item spot'].inventory_slot_number].item_slot_local)
			print("my_p.slot_num: ", my_p.slot_num)
			Global.inventory[data['item spot'].inventory_slot_number].item_slot_local = my_p.slot_num
		
	#my_p.inventory_slot_number = data['item spot'].inventory_slot_number
	data['item spot'].item_num = -1
	#data['item spot'].inventory_slot_number = -1
	
	if !item_deleted:
		var my_item = Global.inventory[data['item spot'].inventory_slot_number]
		
		if my_item.stack_max > 0:
			data['item spot'].toggle_label_visibility()
			data['item spot'].set_amount_label(0, 0)
			my_p.toggle_label_visibility()
			my_p.set_amount_label(my_item.amount_in_stack, my_item.stack_max)
			
		get_parent().get_parent().is_taken = true
	
func _process(delta):
	if mouse_default_cursor_shape == CURSOR_POINTING_HAND:
		get_parent().get_parent().display_description()
	else:
		get_parent().get_parent().display_nothing()
		
func find_item(data):
	for i in Global.inventory:
		if i.id_no == data['item num'] and i.item_slot_local == data['spot num']:
			return i
	return null
