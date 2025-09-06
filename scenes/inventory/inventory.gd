class_name Inventory
extends TextureRect

@export var grid: GridContainer

func _ready() -> void:
	for bird in game_manager.game_data.birds:
		_create_inventory_item(bird, GameManager.InventoryType.BIRDS)
	for food in game_manager.game_data.food:
		_create_inventory_item(food, GameManager.InventoryType.FOOD)
	for grocery in game_manager.game_data.groceries:
		_create_inventory_item(grocery, GameManager.InventoryType.GROCERIES)

func _create_inventory_item(item: int, type: GameManager.InventoryType) -> void:
	var inventory_item: InventoryItem = load(Resources.scenes[Resources.Scene.INVENTORY_ITEM]).instantiate()
	inventory_item.type = type
	inventory_item.item = item
	grid.add_child(inventory_item)

func on_close_pressed() -> void:
	self.queue_free()
