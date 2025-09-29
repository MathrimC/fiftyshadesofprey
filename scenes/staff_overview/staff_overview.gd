class_name StaffOverview
extends Control

enum Page { SCIENTISTS, STAFF }
enum Context { RESUMES, STAFF }

@export var page_button_group: ButtonGroup
@export var container: Container
var page: Page
var context: Context

func _ready() -> void:
	page_button_group.pressed.connect(on_page_button_pressed)
	page = Page.SCIENTISTS
	_refresh()

func _refresh() -> void:
	print("refreshing for context %s" % context)
	for child in container.get_children():
		child.queue_free()
	match page:
		Page.SCIENTISTS:
			for scientist: Scientist.Type in _get_scientists():
				var profile: ScientistResume = load(Resources.scenes[Resources.Scene.SCIENTIST_RESUME]).instantiate()
				profile.scientist = scientist
				profile.context = context
				container.add_child(profile)
		Page.STAFF:
			for staff: Staff in _get_staff():
				print("adding staff %s" % staff.name)
				var profile: StaffResume = load(Resources.scenes[Resources.Scene.STAFF_RESUME]).instantiate()
				profile.staff = staff
				profile.context = context
				container.add_child(profile)

func _get_scientists() -> Array:
	match context:
		Context.RESUMES:
			return Scientist.Type.values().filter(_filter_scientist_resumes)
		Context.STAFF:
			return game_manager.get_hired_scientists()
	return []

func _filter_scientist_resumes(scientist: Scientist.Type) -> bool:
	return !game_manager.is_scientist_hired(scientist)

func _get_staff() -> Array:
	match context:
		Context.RESUMES:
			return game_manager.game_resources.get_staff().filter(func(_staff): return !game_manager.is_staff_hired(_staff))
		Context.STAFF:
			return game_manager.get_hired_staff()
	return []


func on_page_button_pressed(_button: BaseButton) -> void:
	page = (_button as PageButton).page
	for button in page_button_group.get_buttons():
		button.z_index = 0
	page_button_group.get_pressed_button().z_index = 1
	_refresh()
