extends Control

var good_calls = {
	"#211796":"Bzzz. Bzzz. *Click* *Ker-chunk*"
}

var list = ["", "", "" ,"", "", "", ""]

func number_pressed(letter):
	list.push_back(letter)
	list.pop_front()
	
	var number = check_list()
	if number != null:
		Global.player.display_message(good_calls[number])
		queue_free()
	else:
		pass
	
	
func check_list():
	var builder = ""
	for i in list:
		builder += i
		
	if good_calls.has(builder):
		return builder
	else:
		return null

func _ready():
	for i in $Buttons.get_children():
		i.connect("phone_btn_pressed", self, "number_pressed")

func _on_BtnExit_pressed():
	queue_free()
