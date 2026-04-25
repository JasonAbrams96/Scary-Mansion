class_name GenMap

var map = []
var width = 5
var height = 8

#	Height then width

var glob = Global
var dict = {"a":"Foyer",
			"b":"Normal_Room",
			"c":"Up_Room",
			"d":"Down_Room",
			"e":"Power_Room"
			}

func init_map():
	for i in range(height):
		map.append([])
		for j in range(width):
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
	#	as long as the room is Normal and is either on the (0,y) or (x, y) sides
	#	locked room needs a key
		pass
		
		
func _init():
	init_map()
	gen_map_normals()
	gen_map_stairs()
	
	var string_builder = ""
	for i in range(height):
		for j in range(width):
			string_builder += dict[map[i][j]] + " - "
		string_builder += "\n"
	
	print(string_builder)	
