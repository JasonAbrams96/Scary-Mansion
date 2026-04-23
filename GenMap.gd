extends Node2D

var map = []
var width = 5
var height = 5

var glob = Global
var dict = {"a":"Foyer",
			"b":"Normal_Room",
			"c":"Up_Room",
			"d":"Down_Room",
			"e":"Power_Room"
			}

func init_map():
	for i in range(width):
		map.append([])
		for j in range(height):
			map[i].append("-")
			

#	Generates the map to have the foyer first and then the normal rooms
func gen_map_normals():
	for i in range(height):
		for j in range(width):
			if i == 0 and j == 0:
				map[i][j] = "a"
			else:
				map[i][j] = "b"
			
			
#Generates stairs to go up or down
func gen_map_stairs():
	randomize()
	var layer_y = 0
	
	var down_x = -1
	var down_y = -1
	
	var r_up_x = (randi() % 4) + 1
	
	while (true):
		if layer_y != height - 1:
			map[layer_y][r_up_x] = "c"
			layer_y += 1
			map[layer_y][r_up_x] = "d"
			
			down_x = r_up_x
			down_y = layer_y
		else:
			break
		while(r_up_x == down_x):
			r_up_x = (randi() % 5)
				
func gen_power_room():
	while(true):
		var x = width
		var y = height
		#Generate a power room anywhere on map as long as it is on a normal room
		
		
func _ready():
	init_map()
	gen_map_normals()
	gen_map_stairs()
	
	var string_builder = ""
	for i in range(width):
		for j in range(height):
			string_builder += dict[map[i][j]] + " - "
		string_builder += "\n"
	
	print(string_builder)	
