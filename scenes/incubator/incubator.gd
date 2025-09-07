class_name Incubator
extends Control

@export var container: Container
@export var empty_label: Label
@export var sell_panel: Container
@export var sell_label: Label
var selected_incubatoregg: Incubatoregg

func _ready() -> void:
	sell_panel.hide()
	for dinosaur in game_manager.game_data.eggs:
		var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
		incubatoregg.dinosaur = dinosaur
		incubatoregg.sell_pressed.connect(on_sell_pressed)
		container.add_child(incubatoregg)
	empty_label.visible = game_manager.game_data.eggs.is_empty()
	game_manager.egg_created.connect(on_egg_created)

func _refresh() -> void:
	pass

func _dinosaur_button_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.DINOS)

func on_egg_created(dinosaur: DinosaurInstance) -> void:
	empty_label.hide()
	var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
	incubatoregg.dinosaur = dinosaur
	incubatoregg.sell_pressed.connect(on_sell_pressed)
	container.add_child(incubatoregg)

func on_sell_pressed(incubatoregg: Incubatoregg) -> void:
	selected_incubatoregg = incubatoregg
	var dinosaur := incubatoregg.dinosaur
	var dinosaur_data := game_manager.game_resources.get_dinosaur(dinosaur.type)
	var value := dinosaur_data.value
	if dinosaur.genetics == DinosaurInstance.Genetics.NATURAL:
		value *= 2
	sell_label.text = "Do you want to sell the %s egg for %s?" % [dinosaur_data.name, value]
	sell_panel.show()

func on_sell_yay_pressed() -> void:
	game_manager.sell_egg(selected_incubatoregg.dinosaur)
	selected_incubatoregg.queue_free()
	sell_panel.hide()

func on_sell_nay_pressed() -> void:
	sell_panel.hide()
