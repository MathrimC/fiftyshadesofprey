extends Area2D

@export var active: Texture2D
@export var inactive: Texture2D
@export var scene: Resources.Scene

@export var sprite: Sprite2D

func on_mouse_entered() -> void:
	sprite.texture = active

func on_mouse_exited() -> void:
	sprite.texture = inactive

func on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event is InputEventMouseButton && _event.button_index == MouseButton.MOUSE_BUTTON_LEFT && !_event.pressed:
		get_node("/root/Game").add_child(load(Resources.scenes[scene]).instantiate())
		get_owner().queue_free()
