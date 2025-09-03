class_name GameResources
extends Resource


@export var scientists: Array[Scientist]
@export var groceries: Array[Grocery]
@export var birds: Array[Bird]
@export var dinosaurs: Array[Dinosaur]
@export var foods: Array[Food]

var grocery_dict: Dictionary[Grocery.Type, Grocery]
var scientist_dict: Dictionary[Scientist.Type, Scientist]
var bird_dict: Dictionary[Bird.Type, Bird]
var dinosaur_dict: Dictionary[Dinosaur.Type, Dinosaur]
var food_dict: Dictionary[Food.Type, Food]

func _init() -> void:
	_init_dicts.call_deferred()

func _init_dicts() -> void:
	for scientist in scientists:
		scientist_dict[scientist.type] = scientist
	for grocery in groceries:
		grocery_dict[grocery.type] = grocery
	for bird in birds:
		bird_dict[bird.type] = bird
	for dinosaur in dinosaurs:
		dinosaur_dict[dinosaur.type] = dinosaur
	for food in foods:
		food_dict[food.type] = food

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
