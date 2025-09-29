class_name ScientistButton
extends TextureButton

var scientist: Scientist.Type

func _ready() -> void:
	self.texture_normal = game_manager.game_resources.get_scientist(scientist).texture

func on_pressed() -> void:
	var actions: ScientistActions = load(SceneManager.scenes[SceneManager.Scene.SCIENTIST_ACTIONS]).instantiate()
	actions.scientist = scientist
	get_tree().root.add_child(actions)
	scene_manager.register_scene_switch(SceneManager.Scene.SCIENTIST_ACTIONS, actions)
