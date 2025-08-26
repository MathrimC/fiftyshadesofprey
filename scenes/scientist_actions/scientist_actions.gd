extends Control

@export var scientist_icon: TextureRect
@export var scientist_name: TextureRect
@export var dinosaurs_container: VBoxContainer
@export var food_container: VBoxContainer

var scientist: Resources.Scientist
var dinosaur_lines: Array[DinosaurCreationLine]
var food_lines: Array[FoodCreationLine]

func _ready():
	game_manager.scientist_action_started.connect(on_action_started)
	game_manager.scientist_action_ended.connect(on_action_ended)
	scientist_icon.texture = load("%s/%s" % [Resources.scientist_textures_dir, Resources.scientist_textures[scientist]["icon"]])
	scientist_name.texture = load("%s/%s" % [Resources.scientist_textures_dir, Resources.scientist_textures[scientist]["name"]])
	var scientist_info: Dictionary = game_manager.scientist_info.get(scientist, {})
	for dinosaur in scientist_info.get("dinosaurs", []):
		var line: DinosaurCreationLine = load(Resources.scenes[Resources.Scene.DINOSAUR_CREATION_LINE]).instantiate()
		line.dinosaur = dinosaur
		line.scientist = scientist
		dinosaurs_container.add_child(line)
		dinosaur_lines.append(line)
	for food in scientist_info.get("food", []):
		var line: FoodCreationLine = load(Resources.scenes[Resources.Scene.FOOD_CREATION_LINE]).instantiate()
		line.food = food
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
