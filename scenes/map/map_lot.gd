class_name MapLot
extends TextureButton

@export var lot_number: int

func _ready() -> void:
	owner.refresh_requested.connect(refresh)
	refresh()

func refresh() -> void:
	self.disabled = game_manager.is_lot_occupied(lot_number)

func _pressed() -> void:
	owner.select_lot(lot_number)


