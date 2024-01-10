extends Button

export var number = 0
var direction_to_move = Vector2.DOWN

func _ready():
	$Sprite.frame = number
	
func _on_SlideyPuzzleButton_pressed():
	if direction_to_move.x == -1:
		#Going Left
		

func _on_Tween_tween_all_completed():
	pass # Replace with function body.
