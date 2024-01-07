extends Control

onready var pieces = $Panel/Pieces.get_children()
var puzzle = []
var removed_piece

var good_array = [0, 1, 2, 3, 4, 5, 6, 7, 8]

func _ready():
	for i in range(9):
		puzzle.append([])
		
		print(puzzle)
		
	var x = 0
	for i in range(9):
		#getting the sprite from the pieces...aparently its an array because it won't work otherwise
		puzzle[i].push_back(pieces[x].get_children()[0])
		
		x += 1
	
	scramble()
	
	
func scramble():
	for i in range(9):
		puzzle[i][0].frame = randi() % 9
