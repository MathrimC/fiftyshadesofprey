class_name ParkLot
extends Node2D

const fence_offsets: Dictionary = {
	Enclosure.Fence.WOOD: { "front": Vector2(3.356, 70.47), "back": Vector2(-1.678, -236.577)},
	Enclosure.Fence.GLASS: { "front": Vector2(2.091, 82.46), "back": Vector2(2.091, -216.192)},
	Enclosure.Fence.STEEL: { "front": Vector2(0.258, 19.164), "back": Vector2(0.258, -279.493), "top": Vector2(-0.154, -247.859)}
}

@export var lot_number: int

@onready var enclosure_node: Node2D = get_node("Enclosure")
@onready var biome: Sprite2D = get_node("Enclosure/Biome")
@onready var front_fence: Sprite2D = get_node("Enclosure/FrontFence")
@onready var back_fence: Sprite2D = get_node("Enclosure/BackFence")
@onready var top_fence: Sprite2D = get_node("Enclosure/TopFence")

func _ready() -> void:
	var enclosure := game_manager.get_lot_content(lot_number)
	if enclosure != null:
		print("enclosure not null")
		biome.texture = load("%s/%s" % [Resources.enclosure_textures_dir, Resources.enclosure_textures[enclosure.biome]])
		front_fence.texture = _get_fence_texture(enclosure.fence, "front")
		front_fence.offset = fence_offsets[enclosure.fence]["front"]
		back_fence.texture = _get_fence_texture(enclosure.fence, "back")
		back_fence.offset = fence_offsets[enclosure.fence]["back"]
		if enclosure.fence == Enclosure.Fence.STEEL && !enclosure.dinosaurs.is_empty():
			top_fence.texture = _get_fence_texture(enclosure.fence, "front")
			top_fence.offset = fence_offsets[enclosure.fence]["top"]
			top_fence.show()
		else:
			top_fence.hide()
		enclosure_node.show()
	else:
		enclosure_node.hide()
	

func _get_fence_texture(type: Enclosure.Fence, side: String) -> Texture:
	return load("%s/%s" % [Resources.fence_textures_dir, Resources.fence_textures[type][side]])
