class_name Groceries
extends Control

@export var grid: GridContainer

func _ready() -> void:
	for grocery in GameManager.groceries_info:
		var grocery_item: GroceryItem = load(Resources.scenes[Resources.Scene.GROCERY_ITEM]).instantiate()
		grocery_item.grocery = grocery
		grid.add_child(grocery_item)

