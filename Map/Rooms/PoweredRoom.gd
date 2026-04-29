extends Node2D

class_name PoweredRoom

var is_light_on = false
export var color_rect_path:NodePath = ""
var color_rect:ColorRect

func _ready():
	color_rect = get_node(color_rect_path)
	
func toggle_light():
	is_light_on = !is_light_on

	color_rect.visible = false
	for i in get_node("Lights").get_children():
		i._light_get_color_rect().visible = false
