extends Node2D
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
			"e":"Power_Room",
			"f":"Red_Room",
			"g":"Green_Room",
			"h":"Yellow_Room",
			"i":"Blue_Room",
			"j":"Dining_Room",
			"k":"Kitchen",
			"l":"Bathroom",
			"m":"Bedroom"
			
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
				
				
func gen_special_rooms():
	gen_power_room()
	gen_powered_rooms()
	
func gen_power_room():
	while(true):
		var rand_x = Global.get_randi() % 2
		var rand_y = Global.get_randi() % height
		
		if rand_x == 1:
			rand_x = width - 1
			
		if map[rand_y][rand_x] == "b":
			map[rand_y][rand_x] = "e"
			break
	#	as long as the room is Normal and is either on the (0,y) or (x, y) sides
	#	locked room needs a key
		pass
		
		
func gen_powered_rooms():
	var p_rooms = ["f", "g", "h", "i"]
	while(true):
		var rand_x = Global.get_randi() % width
		var rand_y = Global.get_randi() % height
		
		if map[rand_y][rand_x] == "b":
			var r =  p_rooms[Global.get_randi() % p_rooms.size()]
			map[rand_y][rand_x] = r
			p_rooms.remove(r)
			
		if p_rooms.size() == 0:
			break
		
func _ready():
	init_map()
	gen_map_normals()
	gen_map_stairs()
	gen_special_rooms()
	
	var string_builder = ""
	for i in range(height):
		for j in range(width):
			string_builder += dict[map[i][j]] + " - "
		string_builder += "\n"
	
	print(string_builder)	
