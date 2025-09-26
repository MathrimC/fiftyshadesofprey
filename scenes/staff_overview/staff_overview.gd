class_name StaffOverview
extends Control

@export var container: Container

func _ready() -> void:
	for scientist in game_manager.get_hired_scientists():
		var profile: ScientistResume = load(Resources.scenes[Resources.Scene.SCIENTIST_RESUME]).instantiate()
		profile.scientist = scientist
		profile.context = ScientistResume.Context.STAFF
		container.add_child(profile)
