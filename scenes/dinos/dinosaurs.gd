extends Control

@export var list_container: Container
@export var lines_container: Container
@export var empty_label: Label
@export var sell_panel: Container
@export var sell_label: Label

var selected_line: DinosaurLine

func _ready() -> void:
	sell_panel.hide()
	var list_empty := true
	for enclosure in game_manager.game_data.enclosures.values():
		for dinosaur in enclosure.dinosaurs:
			var dinosaur_line: DinosaurLine = load(Resources.scenes[Resources.Scene.DINOSAUR_LINE]).instantiate()
			dinosaur_line.dinosaur = dinosaur
			dinosaur_line.sell_pressed.connect(on_sell_pressed)
			lines_container.add_child(dinosaur_line)
			list_empty = false
	if list_empty:
		list_container.hide()
		empty_label.show()
	else:
		list_container.show()
		empty_label.hide()
	game_manager.egg_hatched.connect(on_egg_hatched)

func on_egg_hatched(dinosaur: DinosaurInstance) -> void: 
	empty_label.hide()
	list_container.show()
	var dinosaur_line: DinosaurLine = load(Resources.scenes[Resources.Scene.DINOSAUR_LINE]).instantiate()
	dinosaur_line.dinosaur = dinosaur
	dinosaur_line.sell_pressed.connect(on_sell_pressed)
	lines_container.add_child(dinosaur_line)

func _incubator_button_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.INCUBATOR)

func on_sell_pressed(dinosaur_line: DinosaurLine) -> void:
	selected_line = dinosaur_line
	var dinosaur := selected_line.dinosaur
	var dinosaur_data := game_manager.game_resources.get_dinosaur(dinosaur.type)
	var value := dinosaur_data.value
	if dinosaur.genetics == DinosaurInstance.Genetics.NATURAL:
		value *= 2
	sell_label.text = "Do you want to sell the %s for %s?" % [dinosaur_data.name, value]
	sell_panel.show()

func on_sell_yay_pressed() -> void:
	game_manager.sell_dinosaur(selected_line.dinosaur)
	selected_line.queue_free()
	sell_panel.hide()

func on_sell_nay_pressed() -> void:
	sell_panel.hide()
