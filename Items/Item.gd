extends Resource
class_name Item

#	My name is used to define the name of the item in the inventory screen
export var my_name:String
export var my_description:String
export var amount_in_stack:int
export var stack_max:int
export var item_sprite_path:Resource

export var item_slot_local:Vector2

enum Type { KEY, TEMP, USED}
export(Type) var my_type


func set_item_slot_local(num_in_inventory):
	#TODO
	pass
