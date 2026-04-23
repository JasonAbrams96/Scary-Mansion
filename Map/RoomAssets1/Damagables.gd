extends Sprite

class_name Damagable
var my_frame = -1

export var is_interactable = false
var contents = null
var contents_got = false
var is_player_in_area = false

func _ready():
	Global.connect("change_environment", self, "change")

func _process(delta):
	if !contents_got and is_player_in_area and Input.is_action_just_pressed("Interact"):
		if contents_got == false:
			Global.inventory_add_item(contents)
			contents_got = true
			
func change(is_damaged):
	if hframes <= 2:
		if is_damaged:
			self.frame = 1
		else:
			self.frame = 0
	else:
		if my_frame != -1 and is_damaged:
			frame = my_frame
		else:
			var r = Global.rng.randi() % hframes + 1
			if is_damaged:
				self.frame = r
			elif !is_damaged:
				self.frame = 0


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		is_player_in_area = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		is_player_in_area = false
