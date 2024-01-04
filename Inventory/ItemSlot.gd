extends Control

onready var texture = $Panel/TextureRect
export var slot_num = 0
func set_item_pic(asset):
	texture.texture = asset.item_sprite_path

