extends Sprite2D

func _input(event: InputEvent) -> void:
	if self.texture != null && event is InputEventMouseButton && event.pressed:
		if get_rect().has_point(to_local(get_global_mouse_position())):
			print("dino clicked on lot %s" % owner.lot_number)
