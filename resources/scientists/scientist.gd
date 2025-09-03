class_name Scientist
extends Resource

enum Type { BILL_AYE, DAVE_ABORROW, LINE_GD_TYRONE, AIBERT_1STONE, M4R13_CR13, CASI_NEUTRON}

@export var type: Type
@export var name: String
@export var dinos_to_unlock: int
@export var wage: int
@export var price: int
@export var dinosaurs: Array[Dinosaur.Type]
@export var recipes: Array[FoodRecipe]
@export var can_multitask: bool

@export var texture: Texture
@export var unavailable_texture: Texture
