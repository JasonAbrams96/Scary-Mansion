extends Node

func _ready():
	var inven = Global.inventory
	for i in range(inven):
		$Sprite/Item_Spots.get_children()[i].set_item_pic(inven[i].item_sprite_path)

var start_pos = Vector2(-144, -88)
var off_dist = 37

