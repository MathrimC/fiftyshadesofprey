class_name Enclosure
extends Resource

@export var lot_number: int
@export var biome: Biome.Type
@export var fence: Fence.Type
@export var dinosaurs: Array[DinosaurInstance]

func _init(_lot_number: int = 0, _biome: Biome.Type = Biome.Type.FOREST, _fence: Fence.Type = Fence.Type.WOOD) -> void:
	lot_number = _lot_number
	biome = _biome
	fence = _fence

func add_dinosaur(dinosaur: DinosaurInstance) -> bool:
	if is_full():
		return false
	else:
		dinosaurs.append(dinosaur)
		# TODO: manage mood precedence: hungry or sad?
		if game_manager.game_resources.get_dinosaur(dinosaur.type).biome != biome:
			dinosaur.mood = DinosaurInstance.Mood.SAD
			game_manager.notification.emit("%s is in the wrong enclosure and feeling unhappy" % dinosaur.name, game_manager.go_to_enclosure, lot_number)
		else:
			dinosaur.mood = DinosaurInstance.Mood.HAPPY
		return true

func is_full() -> bool:
	return dinosaurs.size() >= 2
