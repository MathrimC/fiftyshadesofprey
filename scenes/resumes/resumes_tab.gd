extends TextureButton

@export var scene: Resources.Scene

func _on_pressed() -> void:
	game_manager.switch_scene(scene)
