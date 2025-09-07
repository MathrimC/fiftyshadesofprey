class_name Incubator
extends Control

@export var container: Container
@export var empty_label: Label

func _ready() -> void:
	for dinosaur in game_manager.game_data.eggs:
		var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
		incubatoregg.dinosaur = dinosaur
		container.add_child(incubatoregg)
	empty_label.visible = game_manager.game_data.eggs.is_empty()
	game_manager.egg_created.connect(on_egg_created)

func _dinosaur_button_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.DINOS)

func on_egg_created(dinosaur: DinosaurInstance) -> void:
	empty_label.hide()
	var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
	incubatoregg.dinosaur = dinosaur
	container.add_child(incubatoregg)
