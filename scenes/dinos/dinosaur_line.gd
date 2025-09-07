class_name DinosaurLine
extends HBoxContainer

signal sell_pressed(dinosaur_line: DinosaurLine)

var dinosaur: DinosaurInstance

@onready var image: TextureRect = get_node("Image")
@onready var dino_name: Label = get_node("Name")
@onready var type: Label = get_node("Type")
@onready var mood: Label = get_node("Mood")

func _ready() -> void:
	_refresh()

func _refresh() -> void:
	var dinosaur_data := game_manager.game_resources.get_dinosaur(dinosaur.type)
	image.texture = dinosaur_data.texture
	dino_name.text = dinosaur.name
	type.text = dinosaur_data.name
	mood.text = DinosaurInstance.Mood.keys()[dinosaur.mood].capitalize()

func on_sell_pressed() -> void:
	sell_pressed.emit(self)
