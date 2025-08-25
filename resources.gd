class_name Resources
extends Node

enum Scene {MAIN_MENU, GAME, DINOPARK, BUY, DINOS, STAFF, SCIENCE, MAP, MENU, RESUMES_SCIENTISTS, RESUMES_CAREGIVERS, BIRDS, GROCERIES, SCIENTIST_ACTIONS, INCUBATOR, DINOSAUR_CREATION_LINE, FOOD_CREATION_LINE, INGREDIENT, INCUBATOREGG, INVENTORY, INVENTORY_ITEM}
enum Scientist { BILL_AYE, DAVE_ABORROW, LINE_GD_TYRONE, CASI_NEUTRON, AIBERT_1STONE, M4R13_CR13 }
enum Dinosaur { DIPLODOCUS, STYRACOSAURUS, ANKYLOSAURUS, PTERANODON, SPINOSAURUS }
enum Bird { CHICKEN, DUCK, PIGEON, PINGUIN, TURKEY, OSTRICH, KIWI, PEAFOWL, FLAMINGO, CASSOWARIE }
enum Food { CARNIVORE, HERBIVORE }
enum Groceries { SALT, PEPPER, RED_SLIME, GREEN_SLIME }
enum Biome { FOREST, DESERT, SWAMP }

const scenes: Dictionary = {
	Scene.MAIN_MENU: "res://main_menu.tscn",
	Scene.GAME: "res://game.tscn",
	Scene.DINOPARK: "res://dinopark.tscn",
	Scene.BUY: "res://buy.tscn",
	Scene.DINOS: "res://dinosaurs.tscn",
	Scene.STAFF: "res://staff.tscn",
	Scene.SCIENCE: "res://science.tscn",
	Scene.MAP: "res://map.tscn",
	Scene.MENU: "res://menu.tscn",
	Scene.RESUMES_SCIENTISTS: "res://resumes_scientists.tscn",
	Scene.RESUMES_CAREGIVERS: "res://resumes_caregivers.tscn",
	Scene.BIRDS: "res://birds.tscn",
	Scene.GROCERIES: "res://groceries.tscn",
	Scene.SCIENTIST_ACTIONS: "res://scientist_actions.tscn",
	Scene.INCUBATOR: "res://incubator.tscn",
	Scene.DINOSAUR_CREATION_LINE: "res://dinosaur_creation_line.tscn",
	Scene.FOOD_CREATION_LINE: "res://food_creation_line.tscn",
	Scene.INGREDIENT: "res://ingredient.tscn",
	Scene.INCUBATOREGG: "res://incubatoregg.tscn",
	Scene.INVENTORY: "res://inventory.tscn",
	Scene.INVENTORY_ITEM: "res://inventory_item.tscn",
}

const food_textures_dir := "res://img/science"
const food_textures: Dictionary = {
	Food.CARNIVORE: "food_carnivore.png",
	Food.HERBIVORE: "food_herbivore.png",
}

const biome_textures_dir := "res://img/buy"
const biome_textures: Dictionary = {
	Biome.FOREST: "forest_logo.png",
	Biome.DESERT: "desert_logo.png",
	Biome.SWAMP: "swamp_logo.png",
}

const ingredient_textures_dir := "res://img/buy"
const ingredient_textures: Dictionary = {
	Groceries.SALT: "groceries_salt.png",
	Groceries.PEPPER: "groceries_pepper.png",
	Groceries.RED_SLIME: "groceries_red_slime.png",
	Groceries.GREEN_SLIME: "groceries_buy_green_slime.png",
}


const scientist_textures_dir := "res://img/science"
const scientist_textures: Dictionary = {
	Scientist.BILL_AYE: {
		"icon": "Bill_Aye_icon.png",
		"name": "Bill_Aye_text.png",
		"price": "price_bill.png"
	},
	Scientist.DAVE_ABORROW: {
		"icon": "Dave_Aborrow_icon.png",
		"unavailable": "Dave_Aborrow_icon_unavailable.png",
		"name": "Dave_Aborrow_text.png",
		"price": "price_dave.png"
	},
	Scientist.LINE_GD_TYRONE: {
		"icon": "Line_DG_Tyrone_icon.png",
		"unavailable": "Line_DG_Tyrone_icon_unavailable.png",
		"name": "Line_GD_Tyrone_text.png",
		"price": "price_line.png"
	},
	Scientist.AIBERT_1STONE: {
		"icon": "AiBert_1Stone_icon.png",
		"unavailable": "AiBert_1Stone_icon_unavailable.png",
		"name": "AiBert_1Stone_text.png",
		"price": "price_aibert.png"
	},
	Scientist.M4R13_CR13: {
		"icon": "M4R13_CR13_icon.png",
		"unavailable": "M4R13_CR13_unavailable.png",
		"name": "M4R13_CR13_text.png",
		"price": "price_m4r13.png"
	},
	Scientist.CASI_NEUTRON: {
		"icon": "Sir_Casi_Neutron_icon.png",
		"unavailable": "Sir_Casi_Neutron_icon_unavailable.png",
		"name": "Sir_Casi_Neutron_text.png",
		"price": "price_casi.png"
	}
}
const dinosaur_textures_dir := "res://img/dinos"
const dinosaur_textures: Dictionary = {
	Dinosaur.DIPLODOCUS: {
		"egg": "Diplodocus_egg.png",
		"dino": "Diplodocus.png",
		"name": "Diplodocus_text.png"
	},
	Dinosaur.STYRACOSAURUS: {
		"egg": "Styracosaurus_egg.png",
		"dino": "Styracosaurus.png",
		"name": "Styracosaurus_text.png"
	},
	Dinosaur.ANKYLOSAURUS: {
		"egg": "Ankylosaurus_egg.png",
		"dino": "Ankylosaurus.png",
		"name": "Ankylosaurus_text.png"
	},
	Dinosaur.PTERANODON: {
		"egg": "Pteranodon_egg.png",
		"dino": "Pteranodon.png",
		"name": "Pteranodon_text.png"
	},
	Dinosaur.SPINOSAURUS: {
		"egg": "Spinosaurus_egg.png",
		"dino": "Spinosaurus.png",
		"name": "Spinosaurus_text.png"
	},
}

const bird_textures_dir := "res://img/birds"
const bird_textures: Dictionary = {
	Bird.CHICKEN: {
		"icon": "Science_chickens.png",
		"icon_low": "chicken_icon.png",
		"name": "chicken_text.png",
	},
	Bird.DUCK: {
		"icon": "science_ducks.png",
		"icon_low": "duck_icon.png",
		"name": "duck_text.png",
	}
}


