extends Control

onready var texture = $Panel/TextureRect
export var slot_num = 0
export var item_num = -1
export var inventory_slot_number = -1
export var is_left_hand:bool
export var is_right_hand:bool
export var is_trash_slot:bool

var inventory_screen = null

export var is_taken = false

func _ready():
	inventory_screen = get_parent().get_parent().get_parent()
	
func set_amount_label(ais, sm):
	$Panel/TextureRect/Label.text = String(ais) + "/" + String(sm)
	
func toggle_label_visibility():

	$Panel/TextureRect/Label.visible = !$Panel/TextureRect/Label.visible
	
func set_item_pic(asset):
	texture.texture = asset.item_sprite_path
		
func set_item_num(asset):
	item_num = asset.id_no
	
func set_inventory_slot_number(num):
	inventory_slot_number = num
	
func display_description():
	#children of label 0 is description, 1 is name of item
	if item_num != -1:
		var arr = Global.item_description_label.get_children()
		
		arr[0].text = GlobalItems.items[item_num].my_description
		arr[1].text = GlobalItems.items[item_num].my_name
		
func display_nothing():
	if item_num != -1:
		var arr = Global.item_description_label.get_children()
		
		arr[0].text = ""
		arr[1].text = ""
