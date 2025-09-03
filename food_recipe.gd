class_name FoodRecipe
extends Resource

@export var ingredients: Dictionary[Grocery.Type,int]
@export var outputs: Dictionary[Food.Type,int]
@export var time: int
