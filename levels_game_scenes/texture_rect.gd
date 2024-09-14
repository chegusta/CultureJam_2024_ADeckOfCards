extends TextureRect

func _get_drag_data(at_position):
	return texture


func _can_drop_data(_pos, data):
	return data is Texture2D

func _drop_data(_pos, data):
	texture = data
