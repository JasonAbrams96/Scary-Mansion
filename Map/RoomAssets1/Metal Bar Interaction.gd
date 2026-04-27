extends Area2D


var is_inserted = false

var room = null
export var number:int = 0

var message = ""

func _ready():
	if number == 1:
		$Sprite.frame_coords = Vector2(0, 1)
	elif number == 2:
		$Sprite.frame_coords = Vector2(0, 2)
	elif number == 3:
		$Sprite.frame_coords = Vector2(0, 3)
		
	

func _process(delta):
	if Input.is_action_just_pressed("Interact"):
		if Global.inventory.has("Metal Bar") and !is_inserted:
			Global.emit_signal("item_used", "metal bar")
			$Sprite.frame_coords.x + 1
			room.toggle_light()
		elif !Global.inventory.has("Metal Bar") and is_inserted:
			Global.emit_signal("item_got", "metal bar")
			$Sprite.frame_coords.x - 1
			room.toggle_light()
			
