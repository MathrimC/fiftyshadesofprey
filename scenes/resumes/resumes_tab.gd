extends TextureButton

@export var scene: SceneManager.Scene

func _on_pressed() -> void:
	scene_manager.switch_scene(scene)
