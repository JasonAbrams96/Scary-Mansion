extends Node2D

var keyless_phrase = "Hmmmm, I don't seem to have the key for this door, it seems to be a [COLOR] door knob."
var player_in_area = false

var is_unlocked = false
export var key_needed_name:String
export var scene_to_load:String

func flip_door():
	$StaticBody2D/SideDoor.flip_h = !$StaticBody2D/SideDoor.flip_h

func _ready():
	if key_needed_name == "":
		is_unlocked = true
		
	if scene_to_load == "":
		push_error("A scene to load is needed for " + get_parent().name + " locked door.")


func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("Interact"):
			#Check for item in player hands
			
			if !is_unlocked:
				Global.player.display_message(keyless_phrase)
			else:
				get_tree().change_scene_to(Global.world_stack.pop_back())
			is_unlocked = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		#Display text bubble
		
		

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
