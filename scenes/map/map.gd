class_name Map
extends Control

signal lot_selected(lot_number: int)
signal refresh_requested()

func _ready() -> void:
	pass

func set_mode() -> void:
	pass

func select_lot(lot_number: int):
	lot_selected.emit(lot_number)

func refresh():
	refresh_requested.emit()
