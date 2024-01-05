extends Node

var items = []

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
				items.push_back(resource)
				
			filename = direct.get_next()#Gets next filename
		
		direct.list_dir_end() #Closes directory

