extends Node

var list_of_rooms = []	#Just to get a feel for it until a rooms list is made in a seperate script
var list_of_special_rooms = []
var max_width = 6
var max_height = 8

var created_stairs_on_curr_floor = false
var create_stairs_first_half = false

var rng = RandomNumberGenerator.new()

var map = {}

func _ready():
	print_debug("starting in generate map...")
	rng.seed = 12231996
	populate_special_rooms()
	generate()
	#print_map()
	
	print_debug("Completed in generate map...")
	
	
#	This method will populate special rooms list to take from this list in an order so that 
#		certain rooms that are generated will have what they need generated next
func populate_special_rooms():
	var special_rooms = ["breaker", "bath", "bath", "kitchen", "storage", "storage", "dinning",
						"Tv"]
	var breaker_rooms = ["red", "blue", "yellow", "green"]
	var rand_room = rng.randi() % special_rooms.size()
	var curr = special_rooms[rand_room]
	
	while(special_rooms.size() > 0):
		if curr == "breaker":
			list_of_special_rooms.append(special_rooms[rand_room])
			while breaker_rooms.size() > 0:
				var br = randi() % breaker_rooms.size()
				list_of_special_rooms.append(breaker_rooms[br])
				breaker_rooms.remove(br)
		else:
			list_of_special_rooms.append(special_rooms[rand_room])
			
		special_rooms.remove(rand_room)
				
		if special_rooms.size() != 0:
			rand_room = rng.randi() % special_rooms.size()
			curr = special_rooms[rand_room]
			
	
func generate():
	var amount_in_stairs = 0
	var amount_in_gen = 0
	var curr_room = null
	var prev_room = null
	
	
	for i in max_height:
		for j in max_width:
			var pos = Vector2(j, i)
			
			if i == 0 and j == 0:
				map[pos] = "foyer"
				prev_room = map[pos]
			elif !map.has(pos):
				var special_or_not = rng.randi() % 2
				var temp_hold
				#This is to make a stair anything else to have a better flow of rooms and to not have 
				#	stairs all clumped up in the begginning
				if special_or_not == 0 and create_stairs_first_half:
					temp_hold = special_or_not
					special_or_not = 1
				
				if j > int(max_width / 2.0) and create_stairs_first_half:
					create_stairs_first_half = false
					special_or_not = temp_hold
					temp_hold = null
				elif j <= int(max_width / 2.0) and ! create_stairs_first_half:
					create_stairs_first_half = true
					
				if ((special_or_not == 0 and not created_stairs_on_curr_floor) or (j == max_width - 1 and not created_stairs_on_curr_floor)) and i != max_height -1:
					generate_stairs(j, i)

				elif special_or_not == 1:
					
					var s_rng = rng.randi() % 10
					if s_rng < 7:
						generate_room(j, i)
					elif s_rng >= 7 and list_of_special_rooms.size() > 0:
						generate_special_room(j, i)
						
				else:
					if list_of_special_rooms.size() != 0:
						generate_special_room(j, i)
					else:
						generate_room(j, i)
			else:
				pass
				
		created_stairs_on_curr_floor = false
					
func generate_stairs(x, y):
	
	if y != max_height -1:
		created_stairs_on_curr_floor = true
		var pos = Vector2(x, y + 1)
		map[Vector2(x, y)] = "stair up"
		map[pos] = "stair down"
	else:
		map[Vector2(x, y)] = "STAIR ELSE"
	
func generate_room(x, y):
	var pos = Vector2(x, y)
	
	map[pos] = "gen"
	
	
func generate_special_room(x, y):
	var pos = Vector2(x, y)
	var room = list_of_special_rooms.pop_front()
	
	if room == "" or room == null:
		map[pos] = "NULL"
	else:
		map[pos] = room
	
func print_map():
	var builder = ""
	for i in max_height:
		builder = ""
		for j in max_width:
			if map.has(Vector2(j, i)):
				
				builder += map[Vector2(j, i)] + "--"
			else:
				builder += "\t"
			
		print(builder)
			
