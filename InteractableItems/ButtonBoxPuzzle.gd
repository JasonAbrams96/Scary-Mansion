extends Control

onready var Containers = $ColorRect/Control/VBoxContainer.get_children()

var button_array = []
var but_color_array = []
var row = 5
var col = 5
var is_on = false

func _ready():
	for i in range(row):
		but_color_array.append([])
		button_array.append([])
		
	for i in range(row):
		for j in range(col):
			var temp = Containers[i].get_child(j)
			but_color_array[i].append(temp.get_child(0)) #Gets the texture to change colors later
			var p_button = PressableButton.new()
			p_button.connect("pressed", self, "on_button_pressed", [p_button])
			temp.add_child(p_button)
			p_button.my_pos = Vector2(i, j)
			p_button.modulate.a = 0.0
			button_array[i].append(p_button)
	randomize_buttons()
	
func randomize_buttons():
	var regions = [0, 21, 42]
	var my_color = randi() % 2
	for i in range(row):
		for j in range(col):
			
			but_color_array[i][j].texture.region.position.x = regions[my_color]
			if my_color == 0:
				button_array[i][j].my_type = 0
				my_color = 1
			elif my_color == 1:
				my_color = 0
				button_array[i][j].my_type = 1

			
func on_button_pressed(butt):
	print(butt.my_pos)
	if butt.my_type != PressableButton.Type.DISABLED:
		swap_buttons(butt)
		
func swap_buttons(button):
	var pos = button.my_pos
	# Sets the locations around the button
	var around_array = []
	around_array.append(Vector2(pos.x - 1, pos.y))
	around_array.append(Vector2(pos.x + 1, pos.y))
	around_array.append(Vector2(pos.x, pos.y - 1))
	around_array.append(Vector2(pos.x, pos.y + 1))
	if is_on:
		around_array.append(Vector2(pos.x - 1, pos.y - 1))
		around_array.append(Vector2(pos.x + 1, pos.y + 1))
		around_array.append(Vector2(pos.x + 1, pos.y - 1))
		around_array.append(Vector2(pos.x - 1, pos.y + 1))
		
	# Removes the locations that are illegal
	var around_array_size = around_array.size()
	var i = 0
	while i < around_array_size:
		if (around_array[i].x == -1 or around_array[i].x == row or
			around_array[i].y == -1 or around_array[i].y == col):
			around_array.remove(i)
			around_array_size -= 1
		else:
			i += 1
	
	if is_on:
		around_array.append(button.my_pos)
		
	for ij in range(around_array.size()):
		var the_pos = around_array[ij]
		var the_region = but_color_array[the_pos.x][the_pos.y].texture.region.position.x
		
		if the_region == 0:
			the_region = 21
			button.my_type = 1
		elif the_region == 21:
			the_region = 0
			button.my_type = 0
		but_color_array[the_pos.x][the_pos.y].texture.region.position.x = the_region

	if check_for_solution():
		print("IS GOOOOOOOOOOOOOOD")

func check_for_solution():
	var solution = Global.good_button_codes[1]
	var is_good = true
	for i in range(row):
		for j in range(col):
			if solution[i][j] != button_array[i][j].my_type:
				is_good = false
				break
				
	if is_good: return true 
	else: return false
	
func _on_ExitButton_pressed():
	queue_free()


func _on_Button_pressed():
	is_on = !is_on
	if is_on:
		$Button.text = "On"
	else:
		$Button.text = "Off"
