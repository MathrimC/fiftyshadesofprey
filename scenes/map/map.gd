class_name Map
extends Control

enum Mode { VIEW, BUILD_ENCLOSURE, PLACE_EGG, MOVE_DINOSAUR }

signal lot_selected(lot_number: int)
signal refresh_requested()

@export var mode: Mode

@onready var mouse_icon: TextureRect = get_node("MouseIcon")

func _ready() -> void:
	mouse_icon.position = get_viewport().get_mouse_position() + Vector2(0,0)

func select_lot(lot_number: int):
	lot_selected.emit(lot_number)

func refresh():
	refresh_requested.emit()

func _input(event: InputEvent) -> void:
	if mode == Mode.PLACE_EGG || mode == Mode.MOVE_DINOSAUR:
		if event is InputEventMouseMotion:
			mouse_icon.position += event.relative
