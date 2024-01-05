extends Control

onready var pieces = $Panel/Pieces.get_children()

func _ready():
	scramble()
	
	
func scramble():
	var new_array = []
	#todo
