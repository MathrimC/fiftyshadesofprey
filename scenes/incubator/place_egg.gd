class_name PlaceEgg
extends Node

@export var map: Map
@export var dinosaur_naming: Container

var dinosaur: DinosaurInstance
var selected_lot: int

func _ready() -> void:
	dinosaur_naming.hide()
	map.lot_selected.connect(on_lot_selected)
	map.mouse_icon.texture = game_manager.game_resources.get_dinosaur(dinosaur.type).egg_texture

func on_lot_selected(lot_number: int) -> void:
	if game_manager.place_dinosaur(dinosaur, lot_number):
		selected_lot = lot_number
		map.mouse_icon.texture = null
		dinosaur_naming.show()

func on_name_submitted(dino_name: String) -> void:
	dinosaur.name = dino_name
	game_manager.go_to_enclosure(selected_lot)
