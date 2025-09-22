class_name ResumesStaff
extends Control

@export var container: Container

func _ready() -> void:
	_refresh.call_deferred()

func _refresh() -> void:
	for staff: Staff in game_manager.game_resources.get_staff():
		if !game_manager.is_staff_hired(staff):
			var resume: StaffResume = load(Resources.scenes[Resources.Scene.STAFF_RESUME]).instantiate()
			resume.staff = staff
			container.add_child(resume)
