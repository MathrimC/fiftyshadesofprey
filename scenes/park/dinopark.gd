class_name Dinopark
extends Node

@export var camera: Camera2D

func set_camera_position_on_lot(lot_number: int) -> void:
	camera.position = get_node("Park/ParkLot%s" % lot_number).position
