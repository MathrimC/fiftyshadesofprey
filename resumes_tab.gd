extends TextureButton

@export var scene_path: String

func _on_pressed() -> void:
	get_node("/root/Game").add_child(load(scene_path).instantiate())
	get_owner().queue_free()
