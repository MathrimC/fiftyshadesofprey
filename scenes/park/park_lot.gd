class_name ParkLot
extends Node2D

const fence_offsets: Dictionary = {
	Fence.Type.WOOD: { "front": Vector2(3.356, 70.47), "back": Vector2(-1.678, -236.577)},
	Fence.Type.GLASS: { "front": Vector2(2.091, 82.46), "back": Vector2(2.091, -216.192)},
	Fence.Type.STEEL: { "front": Vector2(0.258, 19.164), "back": Vector2(0.258, -279.493), "top": Vector2(-0.154, -247.859)}
}

@export var lot_number: int

@onready var enclosure_node: Node2D = get_node("Enclosure")
@onready var biome: Sprite2D = get_node("Enclosure/Biome")
@onready var front_fence: Sprite2D = get_node("Enclosure/FrontFence")
@onready var back_fence: Sprite2D = get_node("Enclosure/BackFence")
@onready var top_fence: Sprite2D = get_node("Enclosure/TopFence")
@onready var dinosaur_1: ParkDinosaur = get_node("Enclosure/Dinosaur1")
@onready var dinosaur_2: ParkDinosaur = get_node("Enclosure/Dinosaur2")

func _ready() -> void:
	refresh()
	game_manager.dinosaur_sold.connect(on_dinosaur_sold)

func on_dinosaur_sold(_dinosaur: DinosaurInstance) -> void:
	refresh()

func refresh() -> void:
	var enclosure := game_manager.get_lot_content(lot_number)
	if enclosure != null:
		var game_resources := game_manager.game_resources
		biome.texture = game_resources.get_biome(enclosure.biome).texture
		var fence := game_resources.get_fence(enclosure.fence)
		front_fence.texture = fence.front_texture
		front_fence.position = fence_offsets[enclosure.fence]["front"]
		back_fence.texture = fence.back_texture
		back_fence.position = fence_offsets[enclosure.fence]["back"]
		top_fence.texture = null
		if !enclosure.dinosaurs.is_empty():
			dinosaur_1.set_dinosaur(enclosure.dinosaurs[0])
		else:
			dinosaur_1.clear_dinosaur()
		if enclosure.dinosaurs.size() > 1:
			dinosaur_2.set_dinosaur(enclosure.dinosaurs[1])
		else:
			dinosaur_2.clear_dinosaur()
		for dinosaur in enclosure.dinosaurs:
			if dinosaur.type == Dinosaur.Type.PTERANODON:
				top_fence.texture = fence.top_texture
		if top_fence.texture != null:
			top_fence.offset = fence_offsets[enclosure.fence].get("top", Vector2(0,0))
			top_fence.show()
		else:
			top_fence.hide()
		enclosure_node.show()
	else:
		enclosure_node.hide()
