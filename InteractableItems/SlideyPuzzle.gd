extends Control

onready var pieces = $Panel/Pieces.get_children()
var puzzle = []
var hidden_piece = null

var good_frames = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

var item_to_win

func _ready():
	randomize()
	var pieces_var = -1
	
	for i in range(3):
		puzzle.append([])
		for j in range(3):
			pieces_var += 1
			puzzle[i].append([])
			puzzle[i][j].append(pieces[pieces_var].get_children()[0])
			
	scramble()
	remove_piece()

func scramble():
	#Scrambles the puzzle
	var arr = [0, 1, 2, 3, 4, 5, 6, 7, 8]
	for i in range(3):
		for j in range(3):
			var r = randi() % arr.size()
			puzzle[i][j][0].frame = arr[r]
			arr.remove(r)

func remove_piece():
	var i = randi() % 3
	var j = randi() % 3
	
	var par = puzzle[i][j][0]
	par.visible = false
	hidden_piece = par

func check_pos(mouse):
	#	Checks each piece to see if the distance to mouse is less than 41 to select the piece that is
	#	clicked on.
	for i in range(3):
		for j in range(3):
			var center = puzzle[i][j][0].get_parent().rect_global_position + puzzle[i][j][0].get_parent().rect_pivot_offset
			if center.distance_to(mouse) < 41:
				return puzzle[i][j][0]
				
func switch(piece):
	if piece == null:
		return false
		
	var diff = piece.global_position - hidden_piece.global_position
	var temp_frame = piece.frame
	
	#cases I don't want to switch pieces
	if diff == Vector2.ZERO:
		return false
	elif diff.x > 88 or diff.x < -88 or diff.y > 88 or diff.x < -88:
		return false
	elif abs(diff.x) == 88 and abs(diff.y) == 88:
		return false
		
	#Actually switches the pieces
	piece.frame = hidden_piece.frame
	hidden_piece.frame = temp_frame
	piece.visible = false
	hidden_piece.visible = true
	hidden_piece = piece
	
	return true
	
func check_puzzle():
	for i in range(3):
		for j in range(3):
			if puzzle[i][j][0].frame != good_frames[i][j]:
				return false
				
	return true
	
func give_item_to_player():
	Global.inventory.append(item_to_win)
	
func _on_piece_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var mb = get_global_mouse_position()
		var piece = check_pos(mb)
		
		if switch(piece):
			if check_puzzle():
				hidden_piece.visible = true
				Global.gates["completed slide puzzle"] = true
				print("Player Won Puzzle") #TODO
		
