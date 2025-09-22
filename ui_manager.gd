class_name UIManager
extends Node

signal show_dino_info_requested(dinosaur: DinosaurInstance)
signal hide_dino_info_requested(dinosaur: DinosaurInstance)

func show_dino_info(dinosaur: DinosaurInstance) -> void:
	show_dino_info_requested.emit(dinosaur)

func hide_dino_info(dinosaur: DinosaurInstance) -> void:
	hide_dino_info_requested.emit(dinosaur)
