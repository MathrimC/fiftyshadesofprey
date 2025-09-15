class_name TitleBar
extends TextureButton

signal move_panel(movement: Vector2)

func _input(event: InputEvent) -> void:
	if self.button_pressed && event is InputEventMouseMotion:
		move_panel.emit(event.relative)
