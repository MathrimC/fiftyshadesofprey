class_name Dinopark
extends Node

@export var camera: Camera2D
@export var dino_info: Container

func _ready() -> void:
	dino_info.hide()

func set_camera_position_on_lot(lot_number: int) -> void:
	camera.position = get_node("Park/ParkLot%s" % lot_number).position
