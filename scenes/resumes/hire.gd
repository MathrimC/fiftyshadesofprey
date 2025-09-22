extends TextureButton

@export var scientist: Scientist.Type

func _on_pressed() -> void:
	game_manager.hire_scientist(scientist)
	self.hide()
