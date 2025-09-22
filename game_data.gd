class_name GameData
extends Resource

const current_version := 2
const starting_money := 5000
const starting_ticket_price := 1
const save_path = "user://savefile.tres"

@export var version: int
@export var day: int
@export var current_day_end_time: int
@export var money: int
@export var ticket_price: int
@export var money_transactions: Array[MoneyTransaction]
@export var eggs: Array[DinosaurInstance]
@export var enclosures: Dictionary[int, Enclosure]
@export var groceries: Dictionary[Grocery.Type, int]
@export var birds: Dictionary[Bird.Type, int]
@export var food: Dictionary[Food.Type, int]
@export var hired_scientists: Array[Scientist.Type]
@export var hired_staff: Array[Staff]
@export var scientist_actions: Dictionary[Scientist.Type, Dictionary]
@export var egg_creation_counters: Dictionary[Dinosaur.Type, int]

func _init():
	version = current_version 
	money = starting_money
	ticket_price = starting_ticket_price
	day = 1

func save() -> void:
	ResourceSaver.save(self, save_path)

static func load() -> GameData:
	var game_data: GameData = ResourceLoader.load(save_path)
	return game_data
