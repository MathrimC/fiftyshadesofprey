class_name StaffResume
extends Control

@export var icon: TextureRect
@export var staff_name: Label
@export var function: Label
@export var wage: Label
@export var available: Container
@export var unavailable: Container
@export var unlock_condition: Label

var staff: Staff

func _ready() -> void:
	refresh()

func _on_hire_pressed() -> void:
	game_manager.hire_staff(staff)
	self.hide()

func refresh() -> void:
	icon.texture = staff.texture
	staff_name.text = "\"%s\"" % staff.name
	function.text = Staff.Type.keys()[staff.type].capitalize()
	wage.text = "%s" % staff.wage
