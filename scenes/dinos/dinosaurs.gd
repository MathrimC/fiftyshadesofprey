extends Control

@export var list_container: Container
@export var lines_container: Container
@export var empty_label: Label

func _ready() -> void:
	var list_empty := true
	for enclosure in game_manager.game_data.enclosures.values():
		for dinosaur in enclosure.dinosaurs:
			var dinosaur_line: DinosaurLine = load(Resources.scenes[Resources.Scene.DINOSAUR_LINE]).instantiate()
			dinosaur_line.dinosaur = dinosaur
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
	lines_container.add_child(dinosaur_line)

func _incubator_button_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.INCUBATOR)
