class_name DinoInfo
extends PanelContainer

@export var dino_name: Label
@export var type: Label
@export var diet: Label
@export var mood: Label

var dinosaur_stack: Array[DinosaurInstance]

func _ready() -> void:
	self.hide()
	ui_manager.show_dino_info_requested.connect(show_dino_info)
	ui_manager.hide_dino_info_requested.connect(hide_dino_info)
	game_manager.dinosaur_changed.connect(on_dinosaur_changed)

func on_dinosaur_changed(_dinosaur: DinosaurInstance) -> void:
	if !dinosaur_stack.is_empty() && dinosaur_stack.back() == _dinosaur:
		refresh()

func refresh() -> void:
	var dinosaur: DinosaurInstance = dinosaur_stack.back()
	dino_name.text = dinosaur.name
	var dino_info = game_manager.game_resources.get_dinosaur(dinosaur.type)
	type.text = dino_info.name
	diet.text = Dinosaur.Diet.keys()[dino_info.diet]
	mood.text = DinosaurInstance.Mood.keys()[dinosaur.mood]

func show_dino_info(_dinosaur: DinosaurInstance) -> void:
	dinosaur_stack.push_back(_dinosaur)
	# dino_info.position = get_viewport().get_mouse_position() + Vector2(20,20)
	refresh()
	self.show()

func hide_dino_info(_dinosaur: DinosaurInstance) -> void:
	dinosaur_stack.erase(_dinosaur)
	if dinosaur_stack.is_empty():
		self.hide()
	else:
		refresh()
