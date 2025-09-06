class_name GameData
extends Resource

const starting_money := 5000
const starting_ticket_price := 1
const save_path = "savefile.tres"

@export var money: int
@export var ticket_price: int
@export var eggs: Array[DinosaurInstance]
# @export var dinosaurs: Array[DinosaurInstance]
@export var enclosures: Dictionary[int, Enclosure]
@export var groceries: Dictionary[Grocery.Type, int]
@export var birds: Dictionary[Bird.Type, int]
@export var food: Dictionary[Food.Type, int]
@export var hired_scientists: Array[Scientist.Type]
@export var scientist_actions: Dictionary[Scientist.Type, Dictionary]

func _init():
	money = starting_money
	ticket_price = starting_ticket_price

func save() -> void:
	ResourceSaver.save(self, save_path)

static func load() -> GameData:
	var game_data: GameData = ResourceLoader.load(save_path)
	return game_data
