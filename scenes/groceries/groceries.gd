class_name Groceries
extends Control

@export var grid: GridContainer
var items: Array[GroceryItem]

func _ready() -> void:
	var groceries := game_manager.get_available_groceries()
	for grocery_type in groceries:
		var grocery_data := game_manager.game_resources.get_grocery(grocery_type)
		var grocery_item: GroceryItem = preload(SceneManager.scenes[SceneManager.Scene.GROCERY_ITEM]).instantiate()
		_set_item.call_deferred(grocery_item, grocery_data)

func _set_item(grocery_item: GroceryItem, grocery: Grocery) -> void:
	grocery_item.grocery = grocery
	grid.add_child(grocery_item)
	items.append(grocery_item)

func _on_buy_pressed() -> void:
	var grocery_amounts: Dictionary[Grocery.Type,int]
	for item in items:
		grocery_amounts[item.grocery.type] = item.amount
		item.clear()
	game_manager.buy_groceries(grocery_amounts)
