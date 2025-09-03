extends TextureButton

@export var scientist: Scientist.Type

func _ready() -> void:
	if game_manager.is_hired(scientist):
		self.hide()

func _on_pressed() -> void:
	game_manager.hire_scientist(scientist)
	self.hide()
