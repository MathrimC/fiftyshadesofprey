class_name ResumesScientists
extends Control

@export var container: Container

func _ready() -> void:
	# for scientist in game_manager.game_data.get_scientists():
	for scientist in Scientist.Type.values():
		if !game_manager.is_hired(scientist):
			var resume: ScientistResume = load(Resources.scenes[Resources.Scene.SCIENTIST_RESUME]).instantiate()
			resume.scientist = scientist
			container.add_child(resume)
