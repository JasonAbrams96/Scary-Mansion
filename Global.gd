extends Node

signal item_got(item)
signal item_used(item)
signal sanity_changed(new_sanity)
signal time_updated(new_time)
signal gui_inventory_closed

var num_of_ghosts = 0
const max_ghosts = 10
var num_of_zombs = 0
const max_zombs = 10

var current_room = "Outside"
var player_has_control = true
var enemies_have_control = true
var sanity = 100

var rendered_rooms = {}
var unrendered_rooms = {}

var inventory = []

var meta_data = {
	"player_pos": Vector2(0,0),
	"inventory": {},
	"player_sanity":100,
}

#	This is to tell if the player has gotten the item or not
var items = {
	"wood key": false,
	"iron key": false,
	"bronze key": false,
	"silver key": false,
	"gold key": false,
	"red book": false,
	"orange book": false,
	"yellow book": false,
	"green book": false,
	"blue book": false,
	"purple book": false,
	"gold book": false,
	"puzzle pieces": false,
	"metal bar": false,
	"lighter" : false,
	"button" : [false, false, false],
	"red gem" : true,
	"blue gem" : true,
	"red diamond" : false,
}

#	These are for if the player has used the item to complete a task
var gates = {
	"got wood key": false,
	"completed puzzle 1": false,
	"completed puzzle 2": false,
	"completed button puzzle" : false,
	"completed box puzzle" : false,
	"completed slide puzzle": false,
}

var good_button_codes = {
	1: [[1, 1, 1, 1, 1], 
		[1, 1, 1, 1, 1], 
		[1, 1, 1, 1, 1], 
		[1, 1, 1, 1, 1], 
		[1, 1, 1, 1, 1]],
	2:[]
}

var time_timer = null
var current_min = 0
var min_max = 60
var current_hour = 0
var hour_max = 24
var min_mult = 1

func _ready():
	time_timer = Timer.new()
	time_timer.wait_time = 1.0
	time_timer.connect("timeout", self, "time_timer_timeout")
	time_timer.pause_mode = PAUSE_MODE_STOP 
	get_tree().current_scene.add_child(time_timer)
	time_timer.start()
	
	#TESTING, REMOVE AFFTER WORKING
	inventory.push_back(GlobalItems.items[0])
	inventory.push_back(GlobalItems.items[2])
	inventory.push_back(GlobalItems.items[1])
	
func set_gate(gate_name):
	gates[gate_name] = true

func set_item(item_name):
	if item_name == "button":
		for i in item_name["button"]:
			if i == false:
				i = true
				break
	else:
		items[item_name] = true


func time_timer_timeout():
	current_min += 1
	if current_min >= min_max:
		current_hour += 1
		current_min = 0
	if current_hour >= hour_max:
		current_hour = 0
	sanity -= 1
	emit_signal("sanity_changed", sanity)
	emit_signal("time_updated")
