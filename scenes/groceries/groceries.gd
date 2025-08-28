class_name Groceries
extends Control

@export var grid: GridContainer
var items: Array[GroceryItem]

func _ready() -> void:
	for grocery in GameManager.groceries_info:
		var grocery_item: GroceryItem = load(Resources.scenes[Resources.Scene.GROCERY_ITEM]).instantiate()
		grocery_item.grocery = grocery
		grid.add_child(grocery_item)
		items.append(grocery_item)

func _on_buy_pressed() -> void:
	var grocery_amounts: Dictionary
	for item in items:
		grocery_amounts[item.grocery] = item.amount
		item.clear()
	game_manager.buy_groceries(grocery_amounts)

