class_name Inventory
extends TextureRect

@export var grid: GridContainer

func _ready() -> void:
	var inventory := game_manager.get_inventory()
	for type in inventory:
		var items: Dictionary = inventory[type]
		for item in items:
			var inventory_item: InventoryItem = load(Resources.scenes[Resources.Scene.INVENTORY_ITEM]).instantiate()
			inventory_item.type = type
			inventory_item.item = item
			grid.add_child(inventory_item)

func on_close_pressed() -> void:
	self.queue_free()
