extends GridContainer

@export var empty_label: Label

func _ready() -> void:
	var hired_scientists := game_manager.get_hired_scientists()
	empty_label.visible = hired_scientists.is_empty()

	for scientist in hired_scientists:
		var scientist_button: ScientistButton = load(SceneManager.scenes[SceneManager.Scene.SCIENTIST_BUTTON]).instantiate()
		scientist_button.scientist = scientist
		add_child(scientist_button)

	if hired_scientists.size() == 1:
		var actions: ScientistActions = load(SceneManager.scenes[SceneManager.Scene.SCIENTIST_ACTIONS]).instantiate()
		actions.scientist = hired_scientists[0]
		get_tree().root.add_child(actions)
		scene_manager.register_scene_switch(SceneManager.Scene.SCIENTIST_ACTIONS, actions)
	

	
