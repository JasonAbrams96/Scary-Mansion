extends Node

var items = {}
var id_num = 0

func _ready():
	print("Loading item resources")
	var path = "res://Items/"
	var direct = Directory.new()
	
	#Opens the path to the items directory
	if direct.open(path) == OK:
		direct.list_dir_begin()
		var filename = direct.get_next()
		
		#While there is a next filename, check to see if it ends with .tres
		while filename != "":
			if filename.ends_with(".tres"):
				#If has .tres then load as a resource
				var resource = ResourceLoader.load(path + filename)
				resource.id_no = id_num
				id_num += 1
				items[resource.id_no] = resource
				
			filename = direct.get_next()#Gets next filename
		
		direct.list_dir_end() #Closes directory

