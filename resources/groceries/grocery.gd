class_name Grocery
extends Resource

enum Type { SALT, PEPPER, GREEN_SLIME, RED_SLIME, BLUE_SLIME }

@export var type: Type
@export var name: String
@export var price: int
@export var texture: Texture
