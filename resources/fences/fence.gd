class_name Fence
extends Resource

enum Type { WOOD, GLASS, STEEL }

@export var type: Type
@export var cost: int
@export var durability: float
@export var icon: Texture
@export var front_texture: Texture
@export var back_texture: Texture
@export var top_texture: Texture
@export var front_broken_texture: Texture
