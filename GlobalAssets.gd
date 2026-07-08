extends Node

var missing_books_sprites = [
			"res://Map/RoomAssets1/BookcaseMBook_B.tscn",
			"res://Map/RoomAssets1/BookcaseMBook_R.tscn",
			"res://Map/RoomAssets1/BookcaseMBook_P.tscn",
			"res://Map/RoomAssets1/BookcaseMBook_O.tscn",
			"res://Map/RoomAssets1/BookcaseMBook_Y.tscn",
			"res://Map/RoomAssets1/BookcaseMBook_G.tscn"
]
var book_items = []
var book_items_was_populated = false

func _populate_book_items():
	if book_items.size() == 0 and !book_items_was_populated:
		book_items.push_back(GlobalItems.items[GlobalItems.items_names["blue book"]])
		book_items.push_back(GlobalItems.items[GlobalItems.items_names["red book"]])
		book_items.push_back(GlobalItems.items[GlobalItems.items_names["purple book"]])
		book_items.push_back(GlobalItems.items[GlobalItems.items_names["orange book"]])
		book_items.push_back(GlobalItems.items[GlobalItems.items_names["yellow book"]])
		book_items.push_back(GlobalItems.items[GlobalItems.items_names["green book"]])
		book_items_was_populated = true
		
		
func get_random_book():
	_populate_book_items()
	var r = int(Global.rng.randi() % missing_books_sprites.size())
	var b = missing_books_sprites[r]
	var bi = book_items[r]
	
	missing_books_sprites.remove(r)
	book_items.remove(r)
	
	var arra = []
	arra.push_back(b)
	arra.push_back(bi)
	
		
	return arra
