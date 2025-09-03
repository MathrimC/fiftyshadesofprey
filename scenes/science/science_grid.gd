extends GridContainer

func _ready() -> void:
	for scientist in game_manager.get_hired_scientists():
		var scientist_button: ScientistButton = load(Resources.scenes[Resources.Scene.SCIENTIST_BUTTON]).instantiate()
		scientist_button.scientist = scientist
		add_child(scientist_button)
	
