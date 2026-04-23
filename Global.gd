extends Node

#	Items Resource variables:
#		My Name
#		My Description
#		Amount In Stack
#		Stack Max
#		Item Sprite Path
#		ID No
#		Item Slot Local
#		My Type

signal item_got(item)
signal item_used(item)
signal sanity_changed(new_sanity)
signal time_updated(new_time)
signal change_environment(is_negative)
signal gui_inventory_closed

var num_of_ghosts = 0
const max_ghosts = 10
var num_of_zombs = 0
const max_zombs = 10
const game_seed = 12231996

var current_room = "Outside"
var player_has_control = true
var enemies_have_control = true
var sanity = 100
var environment_is_changed = false

var player_left_hand_item_id = -1
var player_right_hand_item_id = -1
var player = null

var rng

var rendered_rooms = {}
var unrendered_rooms = {}

var inventory = []
var inventory_open = false
var item_description_label

var meta_data = {
	"player_pos": Vector2(0,0),
	"inventory": {},
	"player_sanity":100,
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
	
	#Setting up rng for generation
	rng = RandomNumberGenerator.new()
	rng.seed = game_seed
	
	#TESTING, REMOVE AFFTER WORKING
	inventory.push_back(GlobalItems.items[0].duplicate())
	inventory.push_back(GlobalItems.items[2].duplicate())
	inventory.push_back(GlobalItems.items[1].duplicate())
	inventory.push_back(GlobalItems.items[6].duplicate())
	inventory_add_item_by_id(GlobalItems.items_names["colored rocks"])
	inventory_add_item_by_id(GlobalItems.items_names["colored rocks"])
	inventory_add_item_by_id(GlobalItems.items_names["colored rocks"])
	inventory_add_item_by_id(GlobalItems.items_names["crowbar"])
	inventory_add_item_by_id(GlobalItems.items_names["crowbar"])
	inventory_add_item_by_id(GlobalItems.items_names["ammo"])

func _process(delta):
	pass
	
func set_gate(gate_name):
	gates[gate_name] = true

func time_timer_timeout():
	current_min += 1
	if current_min >= min_max:
		current_hour += 1
		current_min = 0
	if current_hour >= hour_max:
		sanity -= 2
		emit_signal("sanity_changed", sanity)
		current_hour = 0
	emit_signal("time_updated")
	
	if !environment_is_changed and sanity <= 50:
		environment_is_changed = true
		emit_signal("change_environment", environment_is_changed)
	elif environment_is_changed and sanity > 50:
		environment_is_changed = false
		emit_signal("change_environment", environment_is_changed)
		


func inventory_has_item(name_to_find:String) -> bool:
	var findable = GlobalItems.items_names.has(name_to_find.to_lower())
	if !findable:
		return false
		
	var state = inventory.has(GlobalItems.items[GlobalItems.items_names[name_to_find.to_lower()]])
	
	return state
	
func inventory_delete_item(inventory_number:int):
	inventory.remove(inventory_number)
	
func inventory_remove_item(name_to_return:String, amount:int) -> Item:
	#find item
	var item_no = GlobalItems.items_names[name_to_return.to_lower()]
	var item = GlobalItems.items[item_no]
	
	for i in range(inventory.size()):
		if inventory[i].my_name == item.my_name:
			item = inventory[i]
			
			if item.amount_in_stack <= amount:
				inventory.remove(i)
			elif item.amount_in_stack > amount:
				inventory[i].amount_in_stack -= amount
			elif amount == -1:
				inventory.remove(i)
			print(item)
			return item
	return null
	
func inventory_update():
	for i in range(inventory.size()):
		if inventory[i].amount_in_stack == 0 and inventory[i].stack_max != 0:
			inventory.remove(i)


func inventory_add_item_by_id(item_id):
	var item_to_add = GlobalItems.items[item_id].duplicate()
	var inventory_max_size = 25
	#Check to see if item_to_add has a stack or not
	if item_to_add.stack_max == 0 and inventory.size() != inventory_max_size:
		inventory.push_back(item_to_add)
		return true 
	elif item_to_add.stack_max > 0 and inventory.size() != inventory_max_size:
		for i in range(inventory.size()):
			if (inventory[i].my_name == item_to_add.my_name and inventory[i].id_no == item_to_add.id_no) and inventory[i].amount_in_stack != inventory[i].stack_max:
				var leftover = inventory[i].add_to_stack(item_to_add.amount_in_stack)
				if leftover > 0:
					var extra_item = GlobalItems.items[item_id].duplicate()
					extra_item.amount_in_stack = leftover
					inventory.push_back(extra_item)
				return true
		inventory.push_back(item_to_add)
		return true
	else:
		return false
	
