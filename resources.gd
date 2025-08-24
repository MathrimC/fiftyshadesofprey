class_name Resources
extends Node

# const game_scene_path = "res://game.tscn"
# const dinopark_scene_path = "res://dinopark.tscn"
# const buy_scene_path = "res://buy.tscn"
# const dinos_scene_path = "res://dinos.tscn"
# const staff_scene_path = "res://staff.tscn"
# const science_scene_path = "res://science.tscn"
# const map_scene_path = "res://map.tscn"
# const menu_scene_path = "res://menu.tscn"
# const main_menu_scene_path = "res://main_menu.tscn"

enum Scene {MAIN_MENU, GAME, DINOPARK, BUY, DINOS, STAFF, SCIENCE, MAP, MENU, RESUMES_SCIENTISTS, RESUMES_CAREGIVERS, BIRDS, GROCERIES, BILL_AYE}
enum Scientist { BILL_AYE, DAVE_ABORROW, LINE_GD_TYRONE, CASI_NEUTRON, AIBERT_1STONE, M4R13_CR13 }
enum Dinosaur { DIPLODOCUS, STYRACOSAURUS}
enum Bird { CHICKEN, DUCK, PIGEON, PINGUIN, TURKEY, OSTRICH, KIWI, PEAFOWL, FLAMINGO, CASSOWARIE }

const scenes: Dictionary = {
	Scene.MAIN_MENU: "res://main_menu.tscn",
	Scene.GAME: "res://game.tscn",
	Scene.DINOPARK: "res://dinopark.tscn",
	Scene.BUY: "res://buy.tscn",
	Scene.DINOS: "res://dinos.tscn",
	Scene.STAFF: "res://staff.tscn",
	Scene.SCIENCE: "res://science.tscn",
	Scene.MAP: "res://map.tscn",
	Scene.MENU: "res://menu.tscn",
	Scene.RESUMES_SCIENTISTS: "res://resumes_scientists.tscn",
	Scene.RESUMES_CAREGIVERS: "res://resumes_caregivers.tscn",
	Scene.BIRDS: "res://birds.tscn",
	Scene.GROCERIES: "res://groceries.tscn",
	Scene.BILL_AYE: "res://bill_aye.tscn"
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

