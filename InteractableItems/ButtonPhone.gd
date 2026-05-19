extends Sprite

signal phone_btn_pressed(letter)
export var my_number = ""

func _on_Button_pressed():
	emit_signal("phone_btn_pressed", my_number)
	

func _on_Button_button_down():
	frame_coords.y = 1


func _on_Button_button_up():
	frame_coords.y = 0
