extends Sprite


func _ready():
	Global.connect("change_environment", self, "update")
	
