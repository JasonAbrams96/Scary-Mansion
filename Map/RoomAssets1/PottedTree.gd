extends Sprite

var is_watered = false
var is_ferilized = false
var is_fert_water = false
var is_fruited = false

var in_area = false

var current_state = 0
var fruit_state = 6
var done_state = 7

func _hourly_check():
	if current_state < fruit_state:
		#	If player made fertilized water then every hour plant updates
		if is_fert_water:
			if frame < fruit_state:
				frame += 1
		else:
			if is_watered:
				if frame < fruit_state - 1:
					frame += 1
					is_watered = false
				if is_ferilized and frame == fruit_state - 1:
					is_watered = false
					is_ferilized = false
					frame += 1
	elif current_state == fruit_state:
		is_fruited = true
		Global.disconnect("hour_update", self, "_hourly_check")


func _ready():
	Global.connect("hour_update", self, "_hourly_check")
	
	
func _process(delta):
	if in_area:
		if Input.is_action_just_pressed("Interact"):
			if frame < fruit_state:
				var arr = Global.get_player_hand_item_ids()
				
				if arr[0] != null:
					arr[0].to_upper()
				if arr[1] != null:
					arr[1].to_upper()
					
				Global.player.display_message("TDOO: Needs Worked on")
				is_fert_water = true
				
			elif frame == fruit_state:
				Global.player.display_message("Got Fruit!")
				frame += 1
				
			elif frame == done_state:
				Global.player.display_message("I got a fruit from this tree.")
				
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		in_area = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		in_area = false
