extends Area2D


var player_inside_area = false
enum BOOK_COLOR {BLUE, RED, PURPLE, ORANGE, YELLOW, GREEN, NONE}
export (BOOK_COLOR) var book

func _ready():
	pass
	
func _process(delta):
	if player_inside_area:
		if Input.is_action_just_pressed("Interact"):
			#TODO Check player inventory if they have the same color as the book needed
			#	in one of their hands. If so take item and place on shelf
			var book_to_find = ""
			if book == 0:
				book_to_find = "blue book"
			elif book == 1:
				book_to_find = "red book"
			elif book == 2:
				book_to_find = "purple book"
			elif book == 3:
				book_to_find = "orange book"
			elif book == 4:
				book_to_find = "yellow book"
			elif book == 5:
				book_to_find = "green book"
			
			if Global.items[book_to_find]:
				pass
			else:
				pass
			print("player did the interact")

#Player enters the bookshelf area
func _on_Bookcase_body_entered(body):
	if body.is_in_group("player"):
		player_inside_area = true
		


#Player leaves the bookshelf area
func _on_Bookcase_body_exited(body):
	if body.is_in_group("player"):
		player_inside_area = false
