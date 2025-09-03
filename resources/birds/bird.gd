class_name Bird
extends Resource

enum Type { CHICKEN, DUCK, PIGEON, PENGUIN, TURKEY, OSTRICH, KIWI, PEAFOWL, FLAMINGO, CASSOWARY }

@export var type: Type
@export var name: String
@export var price: int

@export var texture: Texture
