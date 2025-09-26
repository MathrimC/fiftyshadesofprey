class_name ScientistResume
extends Control

enum Context { RESUMES, STAFF }

@export var icon: TextureRect
@export var scientist_name: Label
@export var eggs_container: HBoxContainer
@export var food_container: HBoxContainer
@export var food_amount: Label
@export var cost: Label
@export var cost_type: Label
@export var hire_button: TextureButton
@export var fire_button: Button
@export var available: Container
@export var unavailable: Container
@export var unlock_condition: Label

var scientist: Scientist.Type
var context: Context

func _ready() -> void:
	refresh()

func _on_hire_pressed() -> void:
	game_manager.hire_scientist(scientist)
	self.hide()

func _on_fire_pressed() -> void:
	game_manager.fire_scientist(scientist)
	self.hide()

func refresh() -> void:
	var scientist_data: Scientist = game_manager.game_resources.get_scientist(scientist)
	if (context == Context.RESUMES && game_manager.is_available(scientist)) \
			|| (context == Context.STAFF && game_manager.is_scientist_hired(scientist)):
		icon.texture = scientist_data.texture
		scientist_name.text = "\"%s\"" % scientist_data.name
		for dinosaur: Dinosaur.Type in scientist_data.dinosaurs:
			var dinosaur_data = game_manager.game_resources.get_dinosaur(dinosaur)
			var egg: TextureRect = load(Resources.scenes[Resources.Scene.RESUME_EGG]).instantiate()
			egg.texture = dinosaur_data.egg_texture
			egg.tooltip_text = dinosaur_data.name if game_manager.is_dinosaur_known(dinosaur_data.type) else "???"
			eggs_container.add_child(egg)
		for recipe: FoodRecipe in scientist_data.recipes:
			for food in recipe.outputs:
				var food_info := game_manager.game_resources.get_food(food)
				var food_icon: TextureRect = load(Resources.scenes[Resources.Scene.RESUME_FOOD]).instantiate()
				food_icon.texture = food_info.texture
				food_icon.tooltip_text = food_info.name
				food_container.add_child(food_icon)
				food_amount.text = "%sx" % recipe.outputs[food]
		if scientist_data.wage > 0:
			cost.text = "%s" % scientist_data.wage
			cost_type.text = "/day"
		elif scientist_data.price > 0:
			cost.text = "%s" % scientist_data.price
			cost_type.text = "(1 time cost)"
		hire_button.visible = (context == Context.RESUMES)
		fire_button.visible = (context == Context.STAFF)
		unavailable.hide()
		available.show()
	else:
		icon.texture = scientist_data.unavailable_texture
		unlock_condition.text = "%s dinosaurs needed to unlock" % scientist_data.dinos_to_unlock
		available.hide()
		unavailable.show()
