class_name GameResources
extends Resource


@export var scientists: Array[Scientist]
@export var staff: Array[Staff]
@export var groceries: Array[Grocery]
@export var birds: Array[Bird]
@export var dinosaurs: Array[Dinosaur]
@export var foods: Array[Food]
@export var biomes: Array[Biome]
@export var fences: Array[Fence]

var grocery_dict: Dictionary[Grocery.Type, Grocery]
var scientist_dict: Dictionary[Scientist.Type, Scientist]
var staff_dict: Dictionary[Staff.Type, Array]
var bird_dict: Dictionary[Bird.Type, Bird]
var dinosaur_dict: Dictionary[Dinosaur.Type, Dinosaur]
var food_dict: Dictionary[Food.Type, Food]
var biome_dict: Dictionary[Biome.Type, Biome]
var fence_dict: Dictionary[Fence.Type, Fence]

func _init() -> void:
	_init_dicts.call_deferred()

func _init_dicts() -> void:
	for scientist in scientists:
		scientist_dict[scientist.type] = scientist
	for staff_member: Staff in staff:
		var type_array: Array = staff_dict.get(staff_member.type, [])
		type_array.append(staff)
		staff_dict[staff_member.type] = type_array
	for grocery in groceries:
		grocery_dict[grocery.type] = grocery
	for bird in birds:
		bird_dict[bird.type] = bird
	for dinosaur in dinosaurs:
		dinosaur_dict[dinosaur.type] = dinosaur
	for food in foods:
		food_dict[food.type] = food
	for biome in biomes:
		biome_dict[biome.type] = biome
	for fence in fences:
		fence_dict[fence.type] = fence

func get_staff() -> Array[Staff]:
	return staff

func get_dinosaurs() -> Array[Dinosaur]:
	return dinosaurs

func get_grocery(type: Grocery.Type) -> Grocery:
	return grocery_dict.get(type, null)

func get_scientist(type: Scientist.Type) -> Scientist:
	return scientist_dict.get(type, null)

func get_bird(type: Bird.Type) -> Bird:
	return bird_dict.get(type, null)

func get_dinosaur(type: Dinosaur.Type) -> Dinosaur:
	return dinosaur_dict.get(type, null)

func get_food(type: Food.Type) -> Food:
	return food_dict.get(type, null)

func get_biome(type: Biome.Type) -> Biome:
	return biome_dict.get(type, null)

func get_fence(type: Fence.Type) -> Fence:
	return fence_dict.get(type, null)
