class_name PlaceEgg
extends Node

@export var map: Map
@export var dinosaur_naming: Container

var dinosaur: DinosaurInstance

func _ready() -> void:
	dinosaur_naming.hide()
	map.lot_selected.connect(on_lot_selected)

func on_lot_selected(lot_number: int) -> void:
	if game_manager.place_dinosaur(dinosaur, lot_number):
		dinosaur_naming.show()

func on_name_submitted(dino_name: String) -> void:
	dinosaur.name = dino_name
	game_manager.switch_scene(Resources.Scene.DINOPARK)
	
