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
			#Create a method that combines the stacks if there is an over amount
			return false
		else:
			amount_in_stack += amount_to_add
			return true
			
	return false
