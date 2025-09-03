class_name ScientistActions
extends Control

@export var scientist_icon: TextureRect
@export var scientist_name: Label
@export var dinosaurs_container: VBoxContainer
@export var food_container: VBoxContainer

var scientist: Scientist.Type
var dinosaur_lines: Array[DinosaurCreationLine]
var food_lines: Array[FoodCreationLine]

func _ready():
	game_manager.scientist_action_started.connect(on_action_started)
	game_manager.scientist_action_ended.connect(on_action_ended)
	var scientist_data: Scientist = game_manager.game_resources.get_scientist(scientist)
	scientist_icon.texture = scientist_data.texture
	scientist_name.text = "\"%s\"" % scientist_data.name
	# scientist_icon.texture = load("%s/%s" % [Resources.scientist_textures_dir, Resources.scientist_textures[scientist]["icon"]])
	# scientist_name.texture = load("%s/%s" % [Resources.scientist_textures_dir, Resources.scientist_textures[scientist]["name"]])
	# var scientist_info: Dictionary = game_manager.scientist_info.get(scientist, {})
	for dinosaur in scientist_data.dinosaurs:
		if game_manager.is_unlocked(dinosaur):
			var line: DinosaurCreationLine = load(Resources.scenes[Resources.Scene.DINOSAUR_CREATION_LINE]).instantiate()
			line.dinosaur = dinosaur
			line.scientist = scientist
			dinosaurs_container.add_child(line)
			dinosaur_lines.append(line)
	for recipe in scientist_data.recipes:
		var line: FoodCreationLine = load(Resources.scenes[Resources.Scene.FOOD_CREATION_LINE]).instantiate()
		line.recipe = recipe
		line.scientist = scientist
		food_container.add_child(line)
		food_lines.append(line)
	refresh_action()

func on_action_started(_scientist: Resources.Scientist):
	if _scientist == scientist:
		for line in dinosaur_lines:
			line.disable_action()
		for line in food_lines:
			line.disable_action()
	refresh_action()

func on_action_ended(_scientist: Resources.Scientist):
	if _scientist == scientist:
		for line in dinosaur_lines:
			line.refresh_button()
		for line in food_lines:
			line.refresh_button()


func refresh_action() -> void:
	var action_info := game_manager.get_scientist_action(scientist)
	if !action_info.is_empty():
		for line in dinosaur_lines:
			line.disable_action()
		for line in food_lines:
			line.disable_action()
		match action_info["action"]:
			GameManager.ScientistAction.CREATE_EGG:
				for line in dinosaur_lines:
					if line.dinosaur == action_info["dinosaur"]:
						line.track_action_time(action_info)
						return
			GameManager.ScientistAction.CREATE_FOOD:
				for line in food_lines:
					if line.food == action_info["food"]:
						line.track_action_time(action_info)
						return
