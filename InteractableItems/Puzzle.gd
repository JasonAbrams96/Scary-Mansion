extends Control

var pieces = []
var tween
var just_pressed = false
var won_puzzle = false
var item_to_get

func _ready():
	tween = $Tween
	#Gets the children from the grid container
	for i in $ColorRect/GridContainer.get_children():
		var thing = i.get_child(0)
		pieces.append(thing)
		#	Then appends each sprite to a list
	scramble()
	
	
func set_item(node):
	item_to_get
#	Scrambles the rotation of the sprites
func scramble():
	for i in pieces:
		var r = randi() % 4
		
		if r == 0:
			i.rotation_degrees = 0
		elif r == 1:
			i.rotation_degrees = 90
		elif r == 2:
			i.rotation_degrees = 180
		elif r == 3:
			i.rotation_degrees = 270
		print(i.rotation_degrees)

#	Checks to make sure the puzzle's rotation is in some form of 360
func check_puzzle():
	for i in pieces:
		if int(i.rotation_degrees) % 360 != 0:
			return false
			
	return true
	
	
#	One rotate method to rotate sprite nodes
func rotate(node_sprite):
	
	var begin_rotat_deg = node_sprite.rotation_degrees
	var end_rotat_deg = begin_rotat_deg + 90

	$Tween.interpolate_property(node_sprite, "rotation_degrees", begin_rotat_deg, end_rotat_deg, 0.3, Tween.TRANS_LINEAR)
	tween.start()
	if abs(node_sprite.rotation_degrees) >= 360:
		node_sprite.rotation_degrees = 0
		

# an gui input event to rotate p0
func _on_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p0/Sprite)

#	Tween completed 
func _on_Tween_tween_all_completed():
	$Tween.stop_all()
	
	#Checks the puzzle after animation
	if check_puzzle():
		won_puzzle = true
	if won_puzzle:
		$Timer.start()
	just_pressed = false
	
func _on_p1_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p1/Sprite)

func _on_p2_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p2/Sprite)


func _on_p4_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p4/Sprite)


func _on_p6_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p6/Sprite)


func _on_p8_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p8/Sprite)


func _on_p3_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p3/Sprite)


func _on_p5_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p5/Sprite)


func _on_p7_gui_input(event):
	if event is InputEventMouseButton and !just_pressed:
		just_pressed = true
		rotate($ColorRect/GridContainer/p7/Sprite)


func _on_Timer_timeout():
	$ColorRect/Button.visible = true

func _on_Button_pressed():
	Global.set_gate("completed puzzle 1")
	Global.emit_signal("item_got", "")
	queue_free()
