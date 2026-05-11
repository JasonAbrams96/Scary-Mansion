extends Sprite

func _ready():
	Global.connect("dog_to_house", self, "update_sprite")
	
	
func update_sprite():
	frame = 1
	$DogBowl.frame = 1
