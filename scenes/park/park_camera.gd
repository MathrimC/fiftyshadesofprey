extends Camera2D

const park_size := Vector2i(3456, 1296)

func _input(event: InputEvent) -> void:
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) || Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)) && event is InputEventMouseMotion:
		var new_position: Vector2 = self.position - (event.relative / self.zoom.x)
		self.position = new_position
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		var zoom_factor := minf(self.zoom.x * 1.1, 10.0)
		self.zoom = Vector2(zoom_factor, zoom_factor)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
		var zoom_factor := maxf(self.zoom.x * 0.9, 0.5)
		self.zoom = Vector2(zoom_factor, zoom_factor)
