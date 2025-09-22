class_name DinoInfo
extends PanelContainer

@export var dino_name: Label
@export var type: Label
@export var diet: Label
@export var mood: Label

var dinosaur: DinosaurInstance

func _ready() -> void:
	game_manager.dinosaur_changed.connect(on_dinosaur_changed)

func on_dinosaur_changed(_dinosaur: DinosaurInstance) -> void:
	if _dinosaur == dinosaur:
		refresh()

func refresh() -> void:
	dino_name.text = dinosaur.name
	var dino_info = game_manager.game_resources.get_dinosaur(dinosaur.type)
	type.text = dino_info.name
	diet.text = Dinosaur.Diet.keys()[dino_info.diet]
	mood.text = DinosaurInstance.Mood.keys()[dinosaur.mood]
