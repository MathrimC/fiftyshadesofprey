class_name MoveDinosaur
extends Node

@export var map: Map

var dinosaur: DinosaurInstance

func _ready() -> void:
	map.lot_selected.connect(on_lot_selected)
	map.mouse_icon.texture = game_manager.game_resources.get_dinosaur(dinosaur.type).texture

func on_lot_selected(lot_number: int) -> void:
	if game_manager.move_dinosaur(dinosaur, lot_number):
		game_manager.switch_scene(Resources.Scene.DINOPARK)
