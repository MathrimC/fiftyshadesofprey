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
		return true

func is_full() -> bool:
	return dinosaurs.size() >= 2
