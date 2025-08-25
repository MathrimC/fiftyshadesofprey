class_name GameManager
extends Node

enum ScientistAction { CREATE_EGG, CREATE_FOOD }
enum InventoryType { DINOSAURS, EGGS, BIRDS, FOOD, GROCERIES }

const starting_money := 1000
const starting_ticket_price := 1
const month_time_in_sec := 1200
const scientist_info := {
	Resources.Scientist.BILL_AYE: {
		"name": "Bill Aye",
		"wage": 500,
		"dinosaurs": [Resources.Dinosaur.DIPLODOCUS, Resources.Dinosaur.STYRACOSAURUS],
		"food": [Resources.Food.CARNIVORE, Resources.Food.HERBIVORE],
	},
	Resources.Scientist.DAVE_ABORROW: {
		"name": "Dave Aborrow",
		"wage": 500,
		"dinosaurs": [Resources.Dinosaur.ANKYLOSAURUS, Resources.Dinosaur.PTERANODON, Resources.Dinosaur.SPINOSAURUS],
		"food": [],
	},
	Resources.Scientist.LINE_GD_TYRONE: {
		"name": "Line D.G. Tyrone",
		"wage": 500,
		"dinosaurs": [],
		"food": [],
	},
	Resources.Scientist.AIBERT_1STONE: {
		"name": "AiBert 1stone",
		"wage": 500,
		"dinosaurs": [],
		"food": [],
	},
	Resources.Scientist.M4R13_CR13: {
		"name": "M4R13 CR13",
		"wage": 500,
		"dinosaurs": [],
		"food": [],
	}
}

const dinosaur_info := {
	Resources.Dinosaur.DIPLODOCUS: {
		"popularity": 1,
		"food": Resources.Food.HERBIVORE,
		"biome": Resources.Biome.FOREST,
		"creation_time": 300,
		"incubation_time": 600,
		"birds": {Resources.Bird.CHICKEN: 1}
	},
	Resources.Dinosaur.STYRACOSAURUS: {
		"popularity": 3,
		"food": Resources.Food.CARNIVORE,
		"biome": Resources.Biome.SWAMP,
		"creation_time": 600,
		"incubation_time": 1200,
		"birds": {Resources.Bird.DUCK: 1}
	},
}

const bird_info := {
	Resources.Bird.CHICKEN: {
		"price": 10,
	},
	Resources.Bird.DUCK: {
		"price": 50,
	}
}

const food_info := {
	Resources.Food.CARNIVORE: {
		"ingredients": {
			Resources.Groceries.SALT: 1,
			Resources.Groceries.PEPPER: 1,
		},
		"creation_time" : 300
	},
	Resources.Food.HERBIVORE: {
		"ingredients": {
			Resources.Groceries.SALT: 1,
			Resources.Groceries.PEPPER: 1,
		},
		"creation_time" : 300
	}
}

const groceries_info := {
	Resources.Groceries.SALT: {
		"price": 1,
	},
	Resources.Groceries.PEPPER: {
		"price": 1,
	},
	Resources.Groceries.RED_SLIME: {
		"price": 1,
	},
	Resources.Groceries.GREEN_SLIME: {
		"price": 1,
	},
}

signal scientist_action_started(scientist: Resources.Scientist)
signal scientist_action_ended(scientist: Resources.Scientist)
signal notification(notification: String)
signal money_changed(money: int)
signal ticket_price_changed(price: int)
signal scene_switched(scene: Resources.Scene, node: Node)
signal incubation_started(egg_info: Dictionary)

var hired_scientists: Array[Resources.Scientist]
var bird_stock: Dictionary
var groceries: Dictionary
var money: int
var ticket_price: int
## Key: scientist, value: dictionary with keys "action, "dinosaur"/"food" depending on action and "timer"
var scientist_actions: Dictionary
## Array with dicitonaries with key "dinosaur" and value "timer"
var incubating_eggs: Array[Dictionary]
var dinosaurs: Array[Dictionary]
var inventory: Dictionary

var active_scene: Node

func start_game() -> void:
	hired_scientists.clear()
	bird_stock.clear()
	incubating_eggs.clear()
	inventory.clear()
	money = starting_money
	ticket_price = starting_ticket_price
	get_tree().create_timer(month_time_in_sec).timeout.connect(on_month_passed)
	get_tree().change_scene_to_file(Resources.scenes[Resources.Scene.GAME])


## Returns a dictionary with keys InventoryType and values a dictionary with key the relevant resource type and value the amount
func get_inventory() -> Dictionary:
	return inventory
		
func hire_scientist(scientist: Resources.Scientist) -> void:
	hired_scientists.append(scientist)

func fire_scientist(scientist: Resources.Scientist) -> void:
	hired_scientists.erase(scientist)

func is_hired(scientist: Resources.Scientist) -> bool:
	return hired_scientists.has(scientist)

func get_hired_scientists() -> Array[Resources.Scientist]:
	return hired_scientists

func get_scientist_action(scientist: Resources.Scientist) -> Dictionary:
	return scientist_actions.get(scientist, {})

func create_egg(dinosaur: Resources.Dinosaur, scientist: Resources.Scientist) -> void:
	var birds: Dictionary = dinosaur_info[dinosaur]["birds"]
	for bird in birds:
		bird_stock[bird] -= birds[bird]
	var timer := get_tree().create_timer(dinosaur_info[dinosaur]["creation_time"])
	scientist_actions[scientist] = { "action": ScientistAction.CREATE_EGG, "dinosaur": dinosaur, "timer": timer }
	scientist_action_started.emit(scientist)
	_await_egg(dinosaur, timer, scientist)

func create_food(food: Resources.Food, scientist: Resources.Scientist) -> void:
	var ingredients: Dictionary = food_info[food]["ingredients"]
	for ingredient in ingredients:
		groceries[ingredient] -= ingredients[ingredient]
	var timer := get_tree().create_timer(food_info[food]["creation_time"])
	scientist_actions[scientist] = { "action": ScientistAction.CREATE_FOOD, "food": food, "timer": timer }
	scientist_action_started.emit(scientist)
	_await_food(food, timer, scientist)

func _await_egg(dinosaur: Resources.Dinosaur, timer: SceneTreeTimer, scientist: Resources.Scientist) -> void:
	await timer.timeout
	scientist_actions.erase(scientist)
	scientist_action_ended.emit(scientist)
	var eggs_stock: Dictionary = inventory.get(InventoryType.EGGS, {})
	eggs_stock[dinosaur] = eggs_stock.get(dinosaur, 0) + 1
	inventory[InventoryType.EGGS] = eggs_stock
	trigger_notification("%s egg created!" % Resources.Dinosaur.keys()[dinosaur].capitalize())

func _await_food(food: Resources.Food, timer: SceneTreeTimer, scientist: Resources.Scientist) -> void:
	await timer.timeout
	scientist_actions.erase(scientist)
	scientist_action_ended.emit(scientist)
	var food_stock: Dictionary = inventory.get(InventoryType.FOOD, {})
	food_stock[food] = food_stock.get(food, 0) + 1
	inventory[InventoryType.FOOD] = food_stock
	trigger_notification("%s food created!" % Resources.Food.keys()[food].capitalize())

func use_egg(dinosaur: Resources.Dinosaur) -> void:
	if active_scene != null && active_scene is Incubator:
		var amount = inventory.get(InventoryType.EGGS, {}).get(dinosaur, 0)
		assert(amount > 0, "Error: trying to use an egg the player doesn't have")
		amount -= 1
		inventory[InventoryType.EGGS][dinosaur] = amount
		incubate(dinosaur)

func incubate(dinosaur: Resources.Dinosaur) -> void:
	var egg_info = {"dinosaur": dinosaur, "timer": get_tree().create_timer(dinosaur_info[dinosaur]["incubation_time"])}
	incubating_eggs.append(egg_info)
	incubation_started.emit(egg_info)
	await egg_info["timer"].timeout
	trigger_notification("Egg hatched!")
	incubating_eggs.erase(egg_info)

## The dictionary keys are "dinosaur" and "timer"
func get_incubating_eggs() -> Array[Dictionary]:
	return incubating_eggs

func get_egg_amount(dinosaur: Resources.Dinosaur) -> int:
	return inventory.get(InventoryType.EGGS).get(dinosaur, 0)

func buy_birds(bird_amounts: Dictionary) -> void:
	var price := 0
	for bird in bird_amounts:
		price += bird_info[bird]["price"] * bird_amounts[bird]
		bird_stock[bird] = bird_stock.get(bird,0) + bird_amounts[bird]
	inventory[InventoryType.BIRDS] = bird_stock
	money -= price
	money_changed.emit(money)

func get_bird_amount(bird: Resources.Bird) -> int:
	return inventory.get(InventoryType.BIRDS,{}).get(bird, 0)

func buy_groceries(groceries_amounts: Dictionary) -> void:
	var price := 0
	for product in groceries_amounts:
		price += groceries_info[product]["price"] * groceries_amounts[product]
		groceries[product] = groceries.get(product, 0) + groceries_amounts[product]
	inventory[InventoryType.GROCERIES] = groceries
	money -= price
	money_changed.emit(money)

func get_groceries_amount(product: Resources.Groceries) -> int:
	return inventory.get(InventoryType.GROCERIES,{}).get(product,0)

func trigger_notification(_notification: String) -> void:
	notification.emit(_notification)

func change_ticket_price(price: int) -> void:
	ticket_price = price
	ticket_price_changed.emit(price)

func on_month_passed() -> void:
	for scientist in hired_scientists:
		money -= scientist_info.get(scientist, {}).get("wage", 0)
	money_changed.emit(money)
	get_tree().create_timer(month_time_in_sec).timeout.connect(on_month_passed)

func switch_scene(scene: Resources.Scene) -> void:
	if active_scene != null:
		active_scene.queue_free()
	active_scene = load(Resources.scenes[scene]).instantiate()
	get_tree().root.add_child(active_scene)
	scene_switched.emit(scene, active_scene)
