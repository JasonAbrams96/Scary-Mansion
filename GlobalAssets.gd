extends Node

var missing_books_sprites = {
			"1":preload("res://Assets/Images/House/b_m_book.png"),
			"2":preload("res://Assets/Images/House/r_m_book.png"),
			"3":preload("res://Assets/Images/House/p_m_book.png"),
			"4":preload("res://Assets/Images/House/o_m_book.png"),
			"5":preload("res://Assets/Images/House/y_m_book.png"),
			"6":preload("res://Assets/Images/House/g_m_book.png"),
}

func get_random_book():
	var r = int(Global.rng.randi() % missing_books_sprites.size()) + 1
	var b = missing_books_sprites[String(r)]
	missing_books_sprites.erase(String(r))
	
	var arra = []
	arra.push_back(b)
	
	if r == 1:
		arra.push_back(GlobalItems.items[GlobalItems.items_names["blue book"]])
	elif r == 2:
		arra.push_back(GlobalItems.items[GlobalItems.items_names["red book"]])
	elif r == 3:
		arra.push_back(GlobalItems.items[GlobalItems.items_names["purple book"]])
	elif r == 4:
		arra.push_back(GlobalItems.items[GlobalItems.items_names["orange book"]])
	elif r == 5:
		arra.push_back(GlobalItems.items[GlobalItems.items_names["yellow book"]])
	elif r == 6:
		arra.push_bakc(GlobalItems.items[GlobalItems.items_names["green book"]])
		
	return arra
