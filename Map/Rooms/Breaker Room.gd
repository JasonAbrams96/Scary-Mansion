extends Node2D

export var g_room:NodePath = ""
export var r_room:NodePath = ""
export var y_room:NodePath = ""
export var b_room:NodePath = ""

func _ready():
	if g_room != "":
		$GreenBreaker.room = get_node(g_room)
	if r_room != "":
		$RedBreaker.room = get_node(r_room)
	if y_room != "":
		$YellowBreaker.room = get_node(y_room)
	if b_room != "":
		$BlueBreaker.room = get_node(b_room)
