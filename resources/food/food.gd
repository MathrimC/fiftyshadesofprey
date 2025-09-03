class_name Food
extends Resource

enum Type { HERBIVORE, CARNIVORE, MEGAMIX }

@export var type: Type
@export var name: String
@export var diet: Array[Dinosaur.Diet]
@export var texture: Texture
