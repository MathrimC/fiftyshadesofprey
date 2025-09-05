class_name GameManager
extends Node

enum ScientistAction { CREATE_EGG, CREATE_FOOD }
enum InventoryType { DINOSAURS, EGGS, BIRDS, FOOD, GROCERIES }
enum DinosaurFeeling { HAPPY, SAD, SICK, HUNGRY }

const game_resources: GameResources = preload("res://resources/game_resources.tres")
const starting_money := 1000
const starting_ticket_price := 1
const month_time_in_sec := 1200
const egg_expiration_time := 15 * 60

signal scientist_action_started(scientist: Resources.Scientist)
signal scientist_action_ended(scientist: Resources.Scientist)
signal notification(notification: String)
signal money_changed(money: int)
signal ticket_price_changed(price: int)
signal scene_switched(scene: Resources.Scene, node: Node)
signal egg_created(dinosaur: DinosaurInstance)
signal egg_hatched(dinosaur: DinosaurInstance)

# const game_resources: GameData = preload("res://resources/game_resources.tres")

var hired_scientists: Array[Scientist.Type]
# var bird_stock: Dictionary
# var groceries: Dictionary
var money: int
var ticket_price: int
## Key: scientist, value: dictionary with keys "action, "dinosaur"/"food" depending on action and "timer"
var scientist_actions: Dictionary
## Array with dicitonaries with key "dinosaur" and value "timer"
var incubating_eggs: Array[DinosaurInstance]
var dinosaurs: Array[DinosaurInstance]
var inventory: Dictionary[InventoryType, Dictionary]
var egg_creation_counters: Dictionary
var park_content: Dictionary[int, Enclosure]
var game_data: GameData

var active_scene: Node

func start_game() -> void:
	hired_scientists.clear()
	# bird_stock.clear()
	incubating_eggs.clear()
	inventory.clear()
	game_data = GameData.new()
	var groceries: Dictionary[Grocery.Type, int]
	inventory[InventoryType.GROCERIES] = groceries
	var birds: Dictionary[Bird.Type, int]
	inventory[InventoryType.BIRDS] = birds
	var eggs: Dictionary[Dinosaur.Type, int]
	inventory[InventoryType.EGGS] = eggs
	money = starting_money
	ticket_price = starting_ticket_price
	get_tree().create_timer(month_time_in_sec).timeout.connect(on_month_passed)
	get_tree().change_scene_to_file(Resources.scenes[Resources.Scene.GAME])


## Returns a dictionary with keys InventoryType and values a dictionary with key the relevant resource type and value the amount
func get_inventory() -> Dictionary:
	return inventory
		
func hire_scientist(scientist: Scientist.Type) -> void:
	hired_scientists.append(scientist)

func fire_scientist(scientist: Scientist.Type) -> void:
	hired_scientists.erase(scientist)

func is_hired(scientist: Scientist.Type) -> bool:
	return hired_scientists.has(scientist)

func is_available(scientist: Scientist.Type) -> bool:
	return dinosaurs.size() >= game_resources.get_scientist(scientist).dinos_to_unlock

func get_hired_scientists() -> Array[Scientist.Type]:
	return hired_scientists

func get_scientist_action(scientist: Scientist.Type) -> Dictionary:
	return scientist_actions.get(scientist, {})

func is_unlocked(dinosaur: Dinosaur.Type) -> bool:
	var eggs := game_resources.get_dinosaur(dinosaur).eggs_to_unlock
	for dino in eggs:
		if egg_creation_counters.get(dino,0) < eggs[dino]:
			return false
	return true

func create_egg(dinosaur: Dinosaur.Type, scientist: Scientist.Type) -> void:
	var dinosaur_data := game_resources.get_dinosaur(dinosaur)
	var bird: Bird.Type = dinosaur_data.creation_bird
	# bird_stock[bird] -= bird
	inventory[InventoryType.BIRDS][bird] -= 1
	var timer := get_tree().create_timer(dinosaur_data.creation_time)
	scientist_actions[scientist] = { "action": ScientistAction.CREATE_EGG, "dinosaur": dinosaur, "timer": timer }
	scientist_action_started.emit(scientist)
	_await_egg(dinosaur, timer, scientist)

func create_food(recipe: FoodRecipe, scientist: Scientist.Type) -> void:
	for ingredient in recipe.ingredients:
		inventory[InventoryType.GROCERIES][ingredient] -= recipe.ingredients[ingredient]
	var timer := get_tree().create_timer(recipe.time)
	scientist_actions[scientist] = { "action": ScientistAction.CREATE_FOOD, "recipe": recipe, "timer": timer }
	scientist_action_started.emit(scientist)
	_await_food(recipe, timer, scientist)

func _await_egg(type: Dinosaur.Type, timer: SceneTreeTimer, scientist: Scientist.Type) -> void:
	await timer.timeout
	scientist_actions.erase(scientist)
	scientist_action_ended.emit(scientist)
	var dino := DinosaurInstance.new()
	dino.type = type
	dino.egg_creation_time = Time.get_unix_time_from_system() as int
	dino.stage = DinosaurInstance.Stage.EGG
	dino.genetics = DinosaurInstance.Genetics.GMO
	game_data.incubator.append(dino)
	egg_created.emit(dino)
	
	# var eggs_stock: Dictionary = inventory.get(InventoryType.EGGS, {})
	# eggs_stock[type] = eggs_stock.get(dinosaur, 0) + 1
	# inventory[InventoryType.EGGS] = eggs_stock
	trigger_notification("%s egg created!" % Dinosaur.Type.keys()[type].capitalize())

func _await_food(recipe: FoodRecipe, timer: SceneTreeTimer, scientist: Scientist.Type) -> void:
	await timer.timeout
	scientist_actions.erase(scientist)
	scientist_action_ended.emit(scientist)
	var food_stock: Dictionary = inventory.get(InventoryType.FOOD, {})
	for food in recipe.outputs:
		food_stock[food] = food_stock.get(food, 0) + recipe.outputs[food]
		trigger_notification("%s food created!" % Food.Type.keys()[food].capitalize())
	inventory[InventoryType.FOOD] = food_stock

func use_egg(dinosaur: Dinosaur.Type) -> void:
	printerr("use_egg shouldn't be called anymore")
	# if active_scene != null && active_scene is Incubator:
	# 	var amount = inventory.get(InventoryType.EGGS, {}).get(dinosaur, 0)
	# 	assert(amount > 0, "Error: trying to use an egg the player doesn't have")
	# 	amount -= 1
	# 	inventory[InventoryType.EGGS][dinosaur] = amount
	# 	incubate(dinosaur)
	
func incubate(dinosaur: Dinosaur.Type) -> void:
	printerr("incubate shouldn't be called anymore")
	# var egg_info = {"dinosaur": dinosaur, "timer": get_tree().create_timer(egg_expiration_time)}
	# game_data.incubator.append(
	# incubating_eggs.append(egg_info)
	# incubation_started.emit(egg_info)
	# await egg_info["timer"].timeout
	# trigger_notification("Egg expired!")
	# incubating_eggs.erase(egg_info)
	# var dinosaur_data := {"dinosaur": dinosaur, "feeling": DinosaurFeeling.HAPPY }
	# dinosaurs.append(dinosaur_data)
	# dinosaur_added.emit(dinosaur_data)

func place_dinosaur(dinosaur: DinosaurInstance, lot_number: int) -> bool:
	var enclosure: Enclosure = park_content.get(lot_number, null)
	if enclosure != null && enclosure.add_dinosaur(dinosaur):
		game_data.incubator.erase(dinosaur)
		egg_hatched.emit(dinosaur)
		return true
	else:
		return false

func get_incubating_eggs() -> Array[DinosaurInstance]:
	return game_data.incubator

func get_dinosaurs() -> Array[DinosaurInstance]:
	return game_data.dinosaurs

func get_egg_amount(dinosaur: Dinosaur.Type) -> int:
	return inventory.get(InventoryType.EGGS).get(dinosaur, 0)

func buy_birds(bird_amounts: Dictionary[Bird.Type, int]) -> void:
	var birds: Dictionary[Bird.Type, int] = inventory.get(InventoryType.BIRDS, {})
	var price := 0
	for bird in bird_amounts:
		price += game_resources.get_bird(bird).price * bird_amounts[bird]
		birds[bird] = birds.get(bird,0) + bird_amounts[bird]
	inventory[InventoryType.BIRDS] = birds
	money -= price
	money_changed.emit(money)

func get_bird_amount(bird: Bird.Type) -> int:
	return inventory.get(InventoryType.BIRDS,{}).get(bird, 0)

func get_available_groceries() -> Array[Grocery.Type]:
	var available: Array[Grocery.Type]
	available.assign(Grocery.Type.values())
	if !hired_scientists.has(Scientist.Type.CASI_NEUTRON):
		available.erase(Grocery.Type.BLUE_SLIME)
	return available

func buy_groceries(groceries_amounts: Dictionary[Grocery.Type, int]) -> void:
	var groceries: Dictionary[Grocery.Type, int] = inventory.get(InventoryType.GROCERIES, {})
	var price := 0
	for grocery in groceries_amounts:
		price += game_resources.get_grocery(grocery).price * groceries_amounts[grocery]
		groceries[grocery] = groceries.get(grocery, 0) + groceries_amounts[grocery]
	inventory[InventoryType.GROCERIES] = groceries
	money -= price
	money_changed.emit(money)

func get_groceries_amount(grocery: Grocery.Type) -> int:
	return inventory.get(InventoryType.GROCERIES,{}).get(grocery,0)

func get_food_amount(food: Food.Type) -> int:
	return inventory.get(InventoryType.FOOD,{}).get(food,0)

func is_lot_occupied(lot_number: int) -> bool:
	return park_content.has(lot_number)

func get_lot_content(lot_number: int) -> Enclosure:
	return park_content.get(lot_number, null)

func create_enclosure(lot_number: int, biome: Biome.Type, fence: Fence.Type) -> void:
	assert(!park_content.has(lot_number), "Error: creating enclosure on occupied lot")
	park_content[lot_number] = Enclosure.new(lot_number, biome, fence)

func trigger_notification(_notification: String) -> void:
	notification.emit(_notification)

func change_ticket_price(price: int) -> void:
	ticket_price = price
	ticket_price_changed.emit(price)

func on_month_passed() -> void:
	for scientist in hired_scientists:
		money -= game_resources.get_scientist(scientist).wage
	money_changed.emit(money)
	get_tree().create_timer(month_time_in_sec).timeout.connect(on_month_passed)

func switch_scene(scene: Resources.Scene) -> Node:
	if active_scene != null:
		active_scene.queue_free()
	active_scene = load(Resources.scenes[scene]).instantiate()
	get_tree().root.add_child(active_scene)
	scene_switched.emit(scene, active_scene)
	return active_scene

func register_scene_switch(scene_type: Resources.Scene, scene_instance: Node) -> void:
	if active_scene != null:
		active_scene.queue_free()
	active_scene = scene_instance
	scene_switched.emit(scene_type, scene_instance)
