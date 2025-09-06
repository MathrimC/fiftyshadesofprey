extends Control

@export var container: GridContainer

func _ready() -> void:
	# TODO: remake list of dinosaurs
	pass
	# for dinosaur in game_manager.game_data.dinosaurs:
	# 	var dinosaur_tile: DinosaurTile = load(Resources.scenes[Resources.Scene.DINOSAUR_TILE]).instantiate()
	# 	dinosaur_tile.dinosaur = dinosaur
	# 	container.add_child(dinosaur_tile)
	# game_manager.egg_hatched.connect(on_egg_hatched)

func on_egg_hatched(dinosaur: DinosaurInstance) -> void: 
	var dinosaur_tile: DinosaurTile = load(Resources.scenes[Resources.Scene.DINOSAUR_TILE]).instantiate()
	dinosaur_tile.dinosaur = dinosaur
	container.add_child(dinosaur_tile)

func _incubator_button_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.INCUBATOR)
