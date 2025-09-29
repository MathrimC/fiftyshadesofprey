extends Control

@export var list_container: Container
@export var lines_container: Container
@export var empty_label: Label
@export var name_panel: Container
@export var name_input: LineEdit

var selected_line: DinosaurLine

func _ready() -> void:
	name_panel.hide()
	refresh()
	game_manager.egg_hatched.connect(on_egg_hatched)
	game_manager.dinosaur_sold.connect(on_dinosaur_sold)

func on_dinosaur_sold(_dinosaur: DinosaurInstance) -> void:
	refresh()

func refresh() -> void:
	for child in lines_container.get_children():
		child.queue_free()
	var list_empty := true
	for enclosure in game_manager.game_data.enclosures.values():
		for dinosaur in enclosure.dinosaurs:
			var dinosaur_line: DinosaurLine = load(SceneManager.scenes[SceneManager.Scene.DINOSAUR_LINE]).instantiate()
			dinosaur_line.dinosaur = dinosaur
			dinosaur_line.rename_pressed.connect(on_rename_pressed)
			lines_container.add_child(dinosaur_line)
			list_empty = false
	if list_empty:
		list_container.hide()
		empty_label.show()
	else:
		list_container.show()
		empty_label.hide()


func on_egg_hatched(dinosaur: DinosaurInstance) -> void: 
	empty_label.hide()
	list_container.show()
	var dinosaur_line: DinosaurLine = load(SceneManager.scenes[SceneManager.Scene.DINOSAUR_LINE]).instantiate()
	dinosaur_line.dinosaur = dinosaur
	lines_container.add_child(dinosaur_line)

func _incubator_button_pressed() -> void:
	scene_manager.switch_scene(SceneManager.Scene.INCUBATOR)

func on_rename_pressed(dinosaur_line: DinosaurLine) -> void:
	selected_line = dinosaur_line
	name_input.text = dinosaur_line.dinosaur.name
	name_panel.show()

func on_rename_yay_pressed() -> void:
	selected_line.dinosaur.name = name_input.text
	selected_line.refresh()
	name_panel.hide()

func on_rename_nay_pressed() -> void:
	name_panel.hide()
