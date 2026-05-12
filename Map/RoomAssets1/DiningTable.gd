extends Node2D

#		TODO: make it so the sanity meter can change the things ontop of the table
var in_area_schair = false
var item_needed_schair = null

func _ready():
	item_needed_schair = GlobalItems.items_names["colored rocks"]
	
	
func _process(delta):
	if in_area_schair:
		if Input.is_action_just_pressed("Interact"):
			#check hands for colored rocks, then check stack amount from player hand...
			Global.player.display_message("Checking for colored Rocks for chair.")
			
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area_schair = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area_schair = false
