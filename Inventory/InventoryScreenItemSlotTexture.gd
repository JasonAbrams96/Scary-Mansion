extends TextureRect


func can_drop_data(position, data):
	return true
	return false
	
func get_drag_data(position):
	var data = {}
	data['origin texture'] = texture
	
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
