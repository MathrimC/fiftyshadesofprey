class_name Incubator
extends Control

@export var container: GridContainer

func _ready() -> void:
	for egg_info in game_manager.get_eggs():
		var incubatoregg: Incubatoregg = load(Resources.scenes[Resources.Scene.INCUBATOREGG]).instantiate()
		incubatoregg.egg_info = egg_info
		container.add_child(incubatoregg)
