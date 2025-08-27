extends Control

@export var container: GridContainer

func _ready() -> void:
	for dinosaur_data in game_manager.get_dinosaurs():
		var dinosaur_tile: DinosaurTile = load(Resources.scenes[Resources.Scene.DINOSAUR_TILE]).instantiate()
		dinosaur_tile.dinosaur_data = dinosaur_data
		container.add_child(dinosaur_tile)
	game_manager.dinosaur_added.connect(on_dinosaur_added)

func on_dinosaur_added(dinosaur_data: Dictionary) -> void:
	var dinosaur_tile: DinosaurTile = load(Resources.scenes[Resources.Scene.DINOSAUR_TILE]).instantiate()
	dinosaur_tile.dinosaur_data = dinosaur_data
	container.add_child(dinosaur_tile)

func _incubator_button_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.INCUBATOR)
