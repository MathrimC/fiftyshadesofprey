class_name MapLot
extends TextureButton

@export var lot_number: int

func _ready() -> void:
	self.disabled = game_manager.is_lot_occupied(lot_number)

func _pressed() -> void:
	owner.select_lot(lot_number)


