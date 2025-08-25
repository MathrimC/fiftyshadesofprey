extends Control

@export var scientist_icon: TextureRect
@export var scientist_name: TextureRect
@export var dinosaurs_container: VBoxContainer
@export var food_container: VBoxContainer

var scientist: Resources.Scientist

func _ready():
	scientist_icon.texture = load("%s/%s" % [Resources.scientist_textures_dir, Resources.scientist_textures[scientist]["icon"]])
	scientist_name.texture = load("%s/%s" % [Resources.scientist_textures_dir, Resources.scientist_textures[scientist]["name"]])
	var scientist_info: Dictionary = game_manager.scientist_info.get(scientist, {})
	for dinosaur in scientist_info.get("dinosaurs", []):
		var line: DinosaurCreationLine = load(Resources.scenes[Resources.Scene.DINOSAUR_CREATION_LINE]).instantiate()
		line.dinosaur = dinosaur
		dinosaurs_container.add_child(line)
	for food in scientist_info.get("food", []):
		var line: FoodCreationLine = load(Resources.scenes[Resources.Scene.FOOD_CREATION_LINE]).instantiate()
		line.food = food
		food_container.add_child(line)
