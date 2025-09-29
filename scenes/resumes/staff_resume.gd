class_name StaffResume
extends Control

@export var icon: TextureRect
@export var staff_name: Label
@export var function: Label
@export var wage: Label
@export var hire_button: TextureButton
@export var fire_button: Button
@export var available: Container
@export var unavailable: Container
@export var unlock_condition: Label

var staff: Staff
var context: StaffOverview.Context

func _ready() -> void:
	refresh()

func _on_hire_pressed() -> void:
	game_manager.hire_staff(staff)
	self.hide()

func _on_fire_pressed() -> void:
	game_manager.fire_staff(staff)
	self.hide()

func refresh() -> void:
	if context == StaffOverview.Context.RESUMES || (context == StaffOverview.Context.STAFF && game_manager.is_staff_hired(staff)):
		icon.texture = staff.texture
		staff_name.text = "\"%s\"" % staff.name
		function.text = Staff.Type.keys()[staff.type].capitalize()
		wage.text = "%s" % staff.wage
		hire_button.visible = (context == StaffOverview.Context.RESUMES)
		fire_button.visible = (context == StaffOverview.Context.STAFF)
