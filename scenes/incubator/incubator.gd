class_name Incubator
extends Control

@export var container: GridContainer

func _ready() -> void:
	for egg_info in game_manager.get_incubating_eggs():
		var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
		incubatoregg.egg_info = egg_info
		container.add_child(incubatoregg)
	game_manager.incubation_started.connect(on_incubation_started)

func _dinosaur_button_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.DINOS)

func on_incubation_started(egg_info: Dictionary) -> void:
	var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
	incubatoregg.egg_info = egg_info
	container.add_child(incubatoregg)
