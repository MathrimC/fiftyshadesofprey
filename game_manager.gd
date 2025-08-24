class_name GameManager
extends Node


const month_time_in_sec := 1000
const scientist_info := {
	Resources.Scientist.BILL_AYE: {
		"name": "Bill Aye",
		"wage": 500,
		"dinosaurs": [],
	},
	Resources.Scientist.DAVE_ABORROW: {
		"name": "Dave Aborrow",
		"wage": 500,
		"dinosaurs": [],
	},
	Resources.Scientist.LINE_GD_TYRONE: {
		"name": "Line D.G. Tyrone",
		"wage": 500,
		"dinosaurs": [],
	},
	Resources.Scientist.AIBERT_1STONE: {
		"name": "AiBert 1stone",
		"wage": 500,
		"dinosaurs": [],
	},
	Resources.Scientist.M4R13_CR13: {
		"name": "M4R13 CR13",
		"wage": 500,
		"dinosaurs": [],
	}
}

const dinosaur_info := {
	Resources.Dinosaur.DIPLODOCUS: {
		"popularity": 10,
		"food_type": 0,
		"creation_time": 0,
		"birds": [Resources.Bird.CHICKEN]
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


signal notification(notification: String)
signal money_changed(money: int)
signal ticket_price_changed(price: int)
signal scene_switched(scene: Resources.Scene)

var hired_scientists: Array[Resources.Scientist]
var bird_stock: Dictionary
var money: int
var ticket_price: int

func start_game():
	hired_scientists.clear()
	money = 1000
	get_tree().create_timer(month_time_in_sec).timeout.connect(on_month_passed)

func hire_scientist(scientist: Resources.Scientist) -> void:
	hired_scientists.append(scientist)

func fire_scientist(scientist: Resources.Scientist) -> void:
	hired_scientists.erase(scientist)

func is_hired(scientist: Resources.Scientist) -> bool:
	return hired_scientists.has(scientist)

func get_hired_scientists() -> Array[Resources.Scientist]:
	return hired_scientists

func buy_birds(bird_amounts: Dictionary) -> void:
	var price = 0
	for bird in bird_amounts:
		price += bird_info[bird]["price"] * bird_amounts[bird]
		bird_stock[bird] = bird_stock.get(bird,0) + bird_amounts[bird]
	money -= price
	money_changed.emit(money)

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

# func generate_visitors() -> void:
	
