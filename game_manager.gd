class_name GameManager
extends Node

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
		"incubation_time": 600,
		"birds": {Resources.Bird.CHICKEN: 1}
	},
	Resources.Dinosaur.STYRACOSAURUS: {
		"popularity": 3,
		"food": Resources.Food.CARNIVORE,
		"biome": Resources.Biome.SWAMP,
		"incubation_time": 1200,
		"birds": {Resources.Bird.DUCK: 1}
	}
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
		}
	},
	Resources.Food.HERBIVORE: {
		"ingredients": {
			Resources.Groceries.SALT: 1,
			Resources.Groceries.PEPPER: 1,
		}
	}
}


signal notification(notification: String)
signal money_changed(money: int)
signal ticket_price_changed(price: int)
signal scene_switched(scene: Resources.Scene, node: Node)

var hired_scientists: Array[Resources.Scientist]
var bird_stock: Dictionary
var money: int
var ticket_price: int
var eggs: Array[Dictionary]

var active_scene: Node

func start_game() -> void:
	hired_scientists.clear()
	bird_stock.clear()
	eggs.clear()
	money = starting_money
	ticket_price = starting_ticket_price
	get_tree().create_timer(month_time_in_sec).timeout.connect(on_month_passed)
	get_tree().change_scene_to_file(Resources.scenes[Resources.Scene.GAME])

func hire_scientist(scientist: Resources.Scientist) -> void:
	hired_scientists.append(scientist)

func fire_scientist(scientist: Resources.Scientist) -> void:
	hired_scientists.erase(scientist)

func is_hired(scientist: Resources.Scientist) -> bool:
	return hired_scientists.has(scientist)

func get_hired_scientists() -> Array[Resources.Scientist]:
	return hired_scientists

func create_egg(dinosaur: Resources.Dinosaur) -> void:
	var birds: Dictionary = dinosaur_info[dinosaur]["birds"]
	for bird in birds:
		bird_stock[bird] -= birds[bird]
	var egg_info = {"dinosaur": dinosaur, "timer": get_tree().create_timer(dinosaur_info[dinosaur]["incubation_time"])}
	eggs.append(egg_info)
	incubate(egg_info)

func incubate(egg_info) -> void:
	await egg_info["timer"].timeout
	trigger_notification("Egg hatched!")


## The dictionary keys are "dinosaur" and "timer"
func get_eggs() -> Array[Dictionary]:
	return eggs

func buy_birds(bird_amounts: Dictionary) -> void:
	var price := 0
	for bird in bird_amounts:
		price += bird_info[bird]["price"] * bird_amounts[bird]
		bird_stock[bird] = bird_stock.get(bird,0) + bird_amounts[bird]
	money -= price
	money_changed.emit(money)

func get_bird_amount(bird: Resources.Bird) -> int:
	return bird_stock.get(bird, 0)

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
