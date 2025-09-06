class_name GameManager
extends Node

enum ScientistAction { CREATE_EGG, CREATE_FOOD }
enum InventoryType { DINOSAURS, EGGS, BIRDS, FOOD, GROCERIES }
enum DinosaurFeeling { HAPPY, SAD, SICK, HUNGRY }

const game_resources: GameResources = preload("res://resources/game_resources.tres")
const month_time_in_sec := 1200
const day_time_in_sec := 40
const egg_expiration_time := 15 * 60

signal scientist_action_started(scientist: Scientist.Type)
signal scientist_action_ended(scientist: Scientist.Type)
signal notification(notification: String)
signal money_changed(money: int)
signal ticket_price_changed(price: int)
signal scene_switched(scene: Resources.Scene, node: Node)
signal egg_created(dinosaur: DinosaurInstance)
signal egg_hatched(dinosaur: DinosaurInstance)

var egg_creation_counters: Dictionary
var game_data: GameData

var game_running: bool
var active_scene: Node

func _enter_tree() -> void:
	game_running = false

func start_game() -> void:
	game_data = GameData.new()
	# TODO: adapt day/month timers for save & load
	get_tree().create_timer(month_time_in_sec).timeout.connect(on_month_passed)
	get_tree().create_timer(day_time_in_sec).timeout.connect(on_day_passed)
	get_tree().change_scene_to_file(Resources.scenes[Resources.Scene.GAME])
	game_running = true

func continue_game() -> void:
	game_data = GameData.load()
	get_tree().create_timer(month_time_in_sec).timeout.connect(on_month_passed)
	get_tree().create_timer(day_time_in_sec).timeout.connect(on_day_passed)
	get_tree().change_scene_to_file(Resources.scenes[Resources.Scene.GAME])
	game_running = true

func hire_scientist(scientist: Scientist.Type) -> void:
	game_data.hired_scientists.append(scientist)
	game_data.save()

func fire_scientist(scientist: Scientist.Type) -> void:
	game_data.hired_scientists.erase(scientist)
	game_data.save()

func is_hired(scientist: Scientist.Type) -> bool:
	return game_data.hired_scientists.has(scientist)

func is_available(scientist: Scientist.Type) -> bool:
	var dinosaur_count := 0
	for enclosure in game_data.enclosures.values():
		dinosaur_count = enclosure.dinosaurs.size()
	return dinosaur_count >= game_resources.get_scientist(scientist).dinos_to_unlock

func get_hired_scientists() -> Array[Scientist.Type]:
	return game_data.hired_scientists

func get_scientist_action(scientist: Scientist.Type) -> Dictionary:
	return game_data.scientist_actions.get(scientist, {})

func is_unlocked(dinosaur: Dinosaur.Type) -> bool:
	var eggs := game_resources.get_dinosaur(dinosaur).eggs_to_unlock
	for dino in eggs:
		if egg_creation_counters.get(dino,0) < eggs[dino]:
			return false
	return true

func create_egg(dinosaur: Dinosaur.Type, scientist: Scientist.Type) -> void:
	var dinosaur_data := game_resources.get_dinosaur(dinosaur)
	var bird: Bird.Type = dinosaur_data.creation_bird
	game_data.birds[bird] -= 1
	game_data.scientist_actions[scientist] = { "action": ScientistAction.CREATE_EGG, "dinosaur": dinosaur, "end_time": roundi(Time.get_unix_time_from_system()) + dinosaur_data.creation_time }
	print("Scientist actions: %s" % game_data.scientist_actions)
	game_data.save()
	scientist_action_started.emit(scientist)

func create_food(recipe: FoodRecipe, scientist: Scientist.Type) -> void:
	for ingredient in recipe.ingredients:
		game_data.groceries[ingredient] -= recipe.ingredients[ingredient]
	game_data.scientist_actions[scientist] = { "action": ScientistAction.CREATE_FOOD, "recipe": recipe, "end_time": Time.get_unix_time_from_system() + recipe.time }
	game_data.save()
	scientist_action_started.emit(scientist)

func place_dinosaur(dinosaur: DinosaurInstance, lot_number: int) -> bool:
	var enclosure: Enclosure = game_data.enclosures.get(lot_number, null)
	if enclosure != null && enclosure.add_dinosaur(dinosaur):
		game_data.eggs.erase(dinosaur)
		game_data.save()
		egg_hatched.emit(dinosaur)
		return true
	else:
		return false

func buy_birds(bird_amounts: Dictionary[Bird.Type, int]) -> void:
	var price := 0
	for bird in bird_amounts:
		price += game_resources.get_bird(bird).price * bird_amounts[bird]
		game_data.birds[bird] = game_data.birds.get(bird,0) + bird_amounts[bird]
	game_data.money -= price
	game_data.save()
	money_changed.emit(game_data.money)

func get_bird_amount(bird: Bird.Type) -> int:
	return game_data.birds.get(bird, 0)

func get_available_groceries() -> Array[Grocery.Type]:
	var available: Array[Grocery.Type]
	available.assign(Grocery.Type.values())
	if !game_data.hired_scientists.has(Scientist.Type.CASI_NEUTRON):
		available.erase(Grocery.Type.BLUE_SLIME)
	return available

func buy_groceries(groceries_amounts: Dictionary[Grocery.Type, int]) -> void:
	var price := 0
	for grocery in groceries_amounts:
		price += game_resources.get_grocery(grocery).price * groceries_amounts[grocery]
		game_data.groceries[grocery] = game_data.groceries.get(grocery, 0) + groceries_amounts[grocery]
	game_data.money -= price
	money_changed.emit(game_data.money)
	game_data.save()

func get_groceries_amount(grocery: Grocery.Type) -> int:
	return game_data.groceries.get(grocery,0)

func get_food_amount(food: Food.Type) -> int:
	return game_data.food.get(food,0)

func is_lot_occupied(lot_number: int) -> bool:
	return game_data.enclosures.has(lot_number)

func get_lot_content(lot_number: int) -> Enclosure:
	return game_data.enclosures.get(lot_number, null)

func create_enclosure(lot_number: int, biome: Biome.Type, fence: Fence.Type) -> void:
	assert(!game_data.enclosures.has(lot_number), "Error: creating enclosure on occupied lot")
	game_data.money -= game_resources.get_biome(biome).cost + game_resources.get_fence(fence).cost
	money_changed.emit(game_data.money)
	game_data.enclosures[lot_number] = Enclosure.new(lot_number, biome, fence)
	game_data.save()

func trigger_notification(_notification: String) -> void:
	notification.emit(_notification)

func change_ticket_price(price: int) -> void:
	game_data.ticket_price = price
	ticket_price_changed.emit(game_data.ticket_price)
	game_data.save()

func on_day_passed() -> void:
	print("day passed")
	var total_visitors: int = 0
	var dinosaur_count: Dictionary
	var sad_count: Dictionary
	for enclosure in game_data.enclosures.values():
		for dinosaur: DinosaurInstance in enclosure.dinosaurs:
			dinosaur_count[dinosaur.type] = dinosaur_count.get(dinosaur.type,0) + 1
			if dinosaur.mood == DinosaurInstance.Mood.SAD:
				sad_count[dinosaur.type] = sad_count.get(dinosaur.type, 0) + 1
	for dinosaur in dinosaur_count:
		var dino_visitors := game_manager.game_resources.get_dinosaur(dinosaur).visitors
		var dino_count = dinosaur_count[dinosaur]
		if dino_count > 1:
			dino_visitors *= 2
			dino_visitors += (dino_count - 2) * 10
		if sad_count.get(dinosaur,0) > 0:
			dino_visitors /= 2
		total_visitors += dino_visitors
	var day_income := game_data.ticket_price * total_visitors
	game_data.money += day_income
	game_data.save()
	money_changed.emit(game_data.money)
	get_tree().create_timer(day_time_in_sec).timeout.connect(on_day_passed)

func on_month_passed() -> void:
	for scientist in game_data.hired_scientists:
		game_data.money -= game_resources.get_scientist(scientist).wage
	game_data.save()
	money_changed.emit(game_data.money)
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

func _process(_delta: float) -> void:
	if game_running:
		var time := Time.get_unix_time_from_system()
		for scientist in game_data.scientist_actions:
			var scientist_action = game_data.scientist_actions[scientist]
			if time > scientist_action["end_time"]:
				_complete_scientist_action(scientist_action, scientist)

func _complete_scientist_action(scientist_action: Dictionary, scientist: Scientist.Type):
	game_data.scientist_actions.erase(scientist)
	scientist_action_ended.emit(scientist)
	match scientist_action["action"]:
		ScientistAction.CREATE_EGG:
			var dino := DinosaurInstance.new()
			dino.type = scientist_action["dinosaur"]
			dino.egg_creation_time = Time.get_unix_time_from_system() as int
			dino.stage = DinosaurInstance.Stage.EGG
			dino.genetics = DinosaurInstance.Genetics.GMO
			game_data.eggs.append(dino)
			egg_created.emit(dino)
			trigger_notification("%s egg created!" % game_resources.get_dinosaur(scientist_action["dinosaur"]).name)
		ScientistAction.CREATE_FOOD:
			var recipe: FoodRecipe = scientist_action["recipe"]
			for type: Food.Type in recipe.outputs:
				game_data.food[type] = game_data.food.get(type, 0) + recipe.outputs[type]
				trigger_notification("%s food created!" % game_resources.get_food(type).name)
	game_data.save()
