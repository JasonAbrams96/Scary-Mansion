extends CanvasLayer

var sanity_meter = GlobalAssets
var inventory_opened = false

func _ready():
	Global.connect("sanity_changed", self, "update_sanity")


func _on_InventoryTexture_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and !inventory_opened:
			inventory_opened = true
			var invent_screen = load("res://Inventory/InventoryScreen.tscn")
			add_child(invent_screen.instance())
			Global.connect("gui_inventory_closed", self, "inventory_has_closed")
			
			

func inventory_has_closed():
	inventory_opened = false

func update_sanity(new_sanity):
	if new_sanity >= 99:
		$Panel/SanityTexture.texture.region.position.x = 0
	elif new_sanity >= 90:
		$Panel/SanityTexture.texture.region.position.x = 32	
	elif new_sanity >= 80:
		$Panel/SanityTexture.texture.region.position.x = 64
	elif new_sanity >= 70:
		$Panel/SanityTexture.texture.region.position.x= 96
	elif new_sanity >= 60:
		$Panel/SanityTexture.texture.region.position.x = 128
	elif new_sanity >= 50:
		$Panel/SanityTexture.texture.region.position.x = 160
	elif new_sanity >= 40:
		$Panel/SanityTexture.texture.region.position.x = 192
	elif new_sanity >= 30:
		$Panel/SanityTexture.texture.region.position.x = 224
	elif new_sanity >= 20:
		$Panel/SanityTexture.texture.region.position.x = 256
	elif new_sanity >= 10:
		$Panel/SanityTexture.texture.region.position.x = 288
#	elif new_sanity >= 0:
#		$Panel/SanityTexture.texture.region.position.x = 320
