class_name Dinocodex
extends Control

@export var name_label: Label
@export var image: TextureRect
@export var egg_image: TextureRect
@export var biome_label: Label
@export var diet_label: Label
@export var description_label: RichTextLabel
@export var previous_button: TextureButton
@export var page_label: Label
@export var next_button: TextureButton

var page: int
var dinosaurs: Array[Dinosaur] = game_manager.game_resources.get_dinosaurs()

func _ready() -> void:
	page = 1
	_refresh()

func _on_previous_pressed() -> void:
	page -= 1
	_refresh()

func _on_next_pressed() -> void:
	page += 1
	_refresh()

func go_to_dino(dino: Dinosaur.Type) -> void:
	for i in game_manager.game_resources.dinosaurs.size():
		if game_manager.game_resources.dinosaurs[i].type == dino:
			page = i + 1
			break
	_refresh()

func _refresh() -> void:
	var dinosaur := dinosaurs[page - 1]
	if game_manager.game_data.egg_creation_counters.get(dinosaur.type, 0) > 0:
		name_label.text = dinosaur.name
		image.texture = dinosaur.texture
		egg_image.texture = dinosaur.egg_texture
		biome_label.text = Biome.Type.keys()[dinosaur.biome].capitalize()
		diet_label.text = Dinosaur.Diet.keys()[dinosaur.diet].capitalize()
		description_label.text = dinosaur.description
	else:
		name_label.text = "???"
		image.texture = preload("res://img/buy/unavailable.png")
		egg_image.texture = null
		biome_label.text = "???"
		diet_label.text = "???"
		description_label.text = ""
	page_label.text = "%s/%s" % [page, dinosaurs.size()]
	previous_button.visible = (page != 1)
	next_button.visible = (page != dinosaurs.size())

		
