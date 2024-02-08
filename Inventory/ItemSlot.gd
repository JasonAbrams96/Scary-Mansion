extends Control

onready var texture = $Panel/TextureRect
export var slot_num = 0



func set_amount_label(ais, sm):
	$Panel/TextureRect/Label.text = String(ais) + "/" + String(sm)
	
func toggle_label_visibility():
	$Panel/TextureRect/Label.visible = !$Panel/TextureRect/Label.visible
	
func set_item_pic(asset):
	texture.texture = asset.item_sprite_path

