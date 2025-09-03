extends Node

@export var map: Map

var egg_info: Dictionary

func _ready() -> void:
	map.lot_selected.connect(on_lot_selected)

func on_lot_selected(lot_number: int) -> void:
	pass
	# game_manager.place_egg()



