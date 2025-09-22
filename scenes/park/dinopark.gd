class_name Dinopark
extends Node

@export var camera: Camera2D
@export var dino_info: Container

func _ready() -> void:
	dino_info.hide()
	ui_manager.show_dino_info_requested.connect(show_dino_info)
	ui_manager.hide_dino_info_requested.connect(hide_dino_info)

func set_camera_position_on_lot(lot_number: int) -> void:
	camera.position = get_node("Park/ParkLot%s" % lot_number).position

func show_dino_info(_dinosaur: DinosaurInstance) -> void:
	dino_info.dinosaur = _dinosaur
	# dino_info.position = get_viewport().get_mouse_position() + Vector2(20,20)
	dino_info.refresh()
	dino_info.show()

func hide_dino_info(_dinosaur: DinosaurInstance) -> void:
	dino_info.hide()
