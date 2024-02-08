extends TextureRect

signal visibilty_of_stack()

func can_drop_data(position, data):
	return true
	return false
	
func get_drag_data(position):
	if texture != null:
		var data = {}
		data['origin texture'] = texture
		data['prev spot'] = self
		data['item amount'] = self.get_child(0).text
		
		var drag_texture = TextureRect.new()
		drag_texture.expand = true
		drag_texture.texture = texture
		drag_texture.rect_size = Vector2(28, 28)
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -0.5 * drag_texture.rect_size
		set_drag_preview(control)
		
		return data
	
func drop_data(position, data):
	
	texture = data['origin texture']
	data['prev spot'].texture = null
	if data['prev spot'].get_child(0).visible == true:
		data['prev spot'].get_parent().get_parent().toggle_label_visibility()
		get_child(0).text = data['item amount']
		get_child(0).visible = true
		
