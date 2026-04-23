extends Resource
class_name Item

#	My name is used to define the name of the item in the inventory screen
export var my_name:String
export var my_description:String
export var amount_in_stack:int
export var stack_max:int
export var item_sprite_path:Resource

export var id_no = -1

export var item_slot_local:int = -1

enum Type { KEY, TEMP, USED}
export(Type) var my_type

func add_to_stack(amount_to_add):
	if stack_max != 0:
		if amount_in_stack + amount_to_add > stack_max:
			var leftover = abs((amount_in_stack + amount_to_add) - stack_max)
			amount_in_stack = stack_max
			return leftover
		else:
			amount_in_stack += amount_to_add
			return 0
			
	return -1
	
