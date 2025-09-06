class_name Incubator
extends Control

@export var container: GridContainer

func _ready() -> void:
	for dinosaur in game_manager.game_data.eggs:
		var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
		incubatoregg.dinosaur = dinosaur
		container.add_child(incubatoregg)
	game_manager.egg_created.connect(on_egg_created)

func _dinosaur_button_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.DINOS)

func on_egg_created(dinosaur: DinosaurInstance) -> void:
	var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
	incubatoregg.dinosaur = dinosaur
	container.add_child(incubatoregg)
