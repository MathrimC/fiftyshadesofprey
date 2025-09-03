class_name ScientistResume
extends Control

@export var icon: TextureRect
@export var scientist_name: Label
@export var eggs_container: HBoxContainer
@export var food_container: HBoxContainer
@export var food_amount: Label
@export var cost: Label
@export var cost_type: Label
@export var available: Container
@export var unavailable: Container
@export var unlock_condition: Label

var scientist: Scientist.Type

func _ready() -> void:
	refresh()

func _on_hire_pressed() -> void:
	game_manager.hire_scientist(scientist)
	self.hide()

func refresh() -> void:
	var scientist_data: Scientist = game_manager.game_resources.get_scientist(scientist)
	if true || game_manager.is_available(scientist):
		icon.texture = scientist_data.texture
		# icon.texture = load("%s/%s" % [Resources.scientist_textures_dir, Resources.scientist_textures[scientist]["icon"]])
		# if scientist == Resources.Scientist.M4R13_CR13:
		# 	scientist_name.text = "\"M4R13 CR13\""
		# else:
		scientist_name.text = "\"%s\"" % scientist_data.name
		for dinosaur: Dinosaur.Type in scientist_data.dinosaurs:
			var dinosaur_data = game_manager.game_resources.get_dinosaur(dinosaur)
			var egg: TextureRect = load(Resources.scenes[Resources.Scene.RESUME_EGG]).instantiate()
			egg.texture = dinosaur_data.egg_texture
			eggs_container.add_child(egg)
		# food_amount.text = "%sx" % scientist_info["food_amount"]
		for recipe: FoodRecipe in scientist_data.recipes:
			for food in recipe.outputs:
				var food_icon: TextureRect = load(Resources.scenes[Resources.Scene.RESUME_FOOD]).instantiate()
				food_icon.texture = game_manager.game_resources.get_food(food).texture
				# food_icon.texture = load("%s/%s" % [Resources.food_textures_dir, Resources.food_textures[food]])
				food_container.add_child(food_icon)
				food_amount.text = "%sx" % recipe.outputs[food]
		if scientist_data.wage > 0:
			cost.text = "%s" % scientist_data.wage
			cost_type.text = "/month"
		elif scientist_data.price > 0:
			cost.text = "%s" % scientist_data.price
			cost_type.text = "(1 time cost)"
		unavailable.hide()
		available.show()
	else:
		icon.texture = load("%s/%s" % [Resources.scientist_textures_dir, Resources.scientist_textures[scientist]["unavailable"]])
		unlock_condition.text = "%s dinosaurs needed to unlock" % scientist_data.dinos_to_unlock
		available.hide()
		unavailable.show()
