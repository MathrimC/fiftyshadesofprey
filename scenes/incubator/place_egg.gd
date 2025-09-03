class_name PlaceEgg
extends Node

@export var map: Map

var dinosaur: DinosaurInstance

func _ready() -> void:
	map.lot_selected.connect(on_lot_selected)

func on_lot_selected(lot_number: int) -> void:
	if game_manager.place_dinosaur(dinosaur, lot_number):
		game_manager.switch_scene(Resources.Scene.INCUBATOR)
	# game_manager.place_egg()
