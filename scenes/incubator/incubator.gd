class_name Incubator
extends Control

@export var container: Container
@export var empty_label: Label

func _ready() -> void:
	refresh()
	empty_label.visible = game_manager.game_data.eggs.is_empty()
	game_manager.egg_created.connect(on_egg_created)
	game_manager.egg_sold.connect(on_egg_sold)

func on_egg_sold(_dinosaur: DinosaurInstance) -> void:
	refresh()

func refresh() -> void:
	for child in container.get_children():
		child.queue_free()
	for dinosaur in game_manager.game_data.eggs:
		var incubatoregg: Incubatoregg = load(SceneManager.scenes[SceneManager.Scene.INCUBATOREGG]).instantiate()
		incubatoregg.dinosaur = dinosaur
		container.add_child(incubatoregg)

func _dinosaur_button_pressed() -> void:
	scene_manager.switch_scene(SceneManager.Scene.DINOS)

func on_egg_created(dinosaur: DinosaurInstance) -> void:
	empty_label.hide()
	var incubatoregg: Incubatoregg = load(SceneManager.scenes[SceneManager.Scene.INCUBATOREGG]).instantiate()
	incubatoregg.dinosaur = dinosaur
	container.add_child(incubatoregg)
