class_name ScientistButton
extends TextureButton

var scientist: Scientist.Type

func _ready() -> void:
	self.texture_normal = load(Resources.scientist_textures_dir + "/" + Resources.scientist_textures[scientist]["icon"])

func on_pressed() -> void:
	var actions: ScientistActions = load(Resources.scenes[Resources.Scene.SCIENTIST_ACTIONS]).instantiate()
	actions.scientist = scientist
	get_tree().root.add_child(actions)
	game_manager.register_scene_switch(Resources.Scene.SCIENTIST_ACTIONS, actions)
