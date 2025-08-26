extends Camera2D

const park_size := Vector2i(3456, 1296)

func _ready() -> void:
	self.position = park_size - get_viewport().size / 2

func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) && event is InputEventMouseMotion:
		var new_position: Vector2 = self.position - event.relative
		var viewport_size: Vector2i = get_viewport().size
		self.position = Vector2(clamp(new_position.x, 0 + viewport_size.x / 2, park_size.x - viewport_size.x / 2), clamp(new_position.y, 0 + viewport_size.y / 2, park_size.y - viewport_size.y / 2))
