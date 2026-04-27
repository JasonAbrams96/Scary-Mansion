extends Area2D

var correct_book:Item = null

var player_inside_area = false
var contents = null
var book_set = false
export var is_regular_bookcase = true
var message = ""

func _ready():
	
	if !is_regular_bookcase:
		if book_set:
			correct_book = null
			contents = null
			
		else:
			var b = GlobalAssets.get_random_book()
			set_up_where_book_spawns(b)
		message = "I can make out some sort of spot, it looks like it might be missing a %s" % correct_book.my_name
	else:
		message = "This is a nice looking bookcase. Wonder why this place looks crappy."
	
	pass
	
func _process(delta):
	if player_inside_area:
		if Input.is_action_just_pressed("Interact"):
			if !is_regular_bookcase:
				if !check_hands():
					Global.player.display_message(message)
				else:
					Global.player.display_message("I used the %s. I heard a cachunk." % correct_book.my_name)
			else:
				Global.player.display_message(message)

#Player enters the bookshelf area
func _on_Bookcase_body_entered(body):
	if body.is_in_group("player"):
		player_inside_area = true
		
#Player leaves the bookshelf area
func _on_Bookcase_body_exited(body):
	if body.is_in_group("player"):
		player_inside_area = false


func check_hands():
	if Global.player_left_hand_item_id != -1 and Global.player_left_hand_item_id == correct_book.id_no:
		return true
	elif Global.player_right_hand_item_id != -1 and Global.player_right_hand_item_id == correct_book.id_no:
		return true
	else:
		return false


#			Array is		random_sprite:String, book_needed:Item
func set_up_where_book_spawns(array):
	var book_shelf_choice = (Global.rng.randi() % 3) + 1
	var positions = null
	
	#Chooses teh bookshelf sprite and then chooses the positions tthat the books can be placed in
	if book_shelf_choice == 1:
		$Sprite.frame = 1
		positions = $Book_Positions.get_child(0).get_children()
	elif book_shelf_choice == 2:
		$Sprite.frame = 2
		positions = $Book_Positions.get_child(1).get_children()
	elif book_shelf_choice == 3:
		$Sprite.frame = 3
		positions = $Book_Positions.get_child(2).get_children()
		
		
	#This now gives the positions and then takes a random position to be able to place a book spot
	var position_rand = positions[Global.rng.randi() % positions.size()]
	
	#Sets the random sprite to 
	var sprite = Sprite.new()
	sprite.texture = array[0]
	$Sprite.add_child(sprite)
	
	correct_book = array[1]
	
func open():
	pass

func set_content(asset:Item):
	contents = asset
