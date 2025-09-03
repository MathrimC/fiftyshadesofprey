class_name Map
extends Control

signal lot_selected(lot_number: int)

func _ready() -> void:
	pass

func select_lot(lot_number: int):
	lot_selected.emit(lot_number)
