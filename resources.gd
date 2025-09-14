class_name Resources
extends Node

enum Scene {MAIN_MENU, GAME, DINOPARK, BUY, DINOS, STAFF, SCIENCE, MAP, MENU, RESUMES_SCIENTISTS, RESUMES_CAREGIVERS, BIRDS, GROCERIES, BUILD_ENCLOSURE, GARDEN_CENTER, SCIENTIST_ACTIONS, INCUBATOR, PLACE_EGG, MOVE_DINOSAUR, DINOSAUR_CREATION_LINE, FOOD_CREATION_LINE, INGREDIENT, INCUBATOREGG, INVENTORY, INVENTORY_ITEM, DINOSAUR_LINE, GROCERY_ITEM, SCIENTIST_RESUME, STAFF_RESUME, RESUME_EGG, RESUME_FOOD, SCIENTIST_BUTTON, BIRD_LINE, BIOME_BUTTON, FENCE_BUTTON, MONEY_TAB, MONEY_LINE}
# enum Scientist { BILL_AYE, DAVE_ABORROW, LINE_GD_TYRONE, CASI_NEUTRON, AIBERT_1STONE, M4R13_CR13 }
# enum Dinosaur { DIPLODOCUS, STYRACOSAURUS, ANKYLOSAURUS, PTERANODON, SPINOSAURUS, VELOCIRAPTOR, PARASAUROLOPHUS, ALLOSAURUS, TRICERATOPS, IGUANADON, BRACHIOSAURUS, STEGOSAURUS, TYRANNOSAURUS_REX, HERRERASAURUS, CARNOTAURUS, KENTROSAURUS, PACHYCEPHALOSAURUS, DILOPHOSAURUS, OVIRAPTOR, PROTOCERATOPS }

const scenes: Dictionary = {
	Scene.MAIN_MENU: "res://scenes/main_menu/main_menu.tscn",
	Scene.GAME: "res://scenes/game/game.tscn",
	Scene.DINOPARK: "res://scenes/park/dinopark.tscn",
	Scene.BUY: "res://scenes/buy/buy.tscn",
	Scene.DINOS: "res://scenes/dinos/dinosaurs.tscn",
	Scene.STAFF: "res://scenes/staff/staff.tscn",
	Scene.SCIENCE: "res://scenes/science/science.tscn",
	Scene.MAP: "res://scenes/map/map.tscn",
	# Scene.MENU: "res://menu.tscn",
	Scene.RESUMES_SCIENTISTS: "res://scenes/resumes/resumes_scientists.tscn",
	Scene.RESUMES_CAREGIVERS: "res://scenes/resumes/resumes_caregivers.tscn",
	Scene.BIRDS: "res://scenes/birds/birds.tscn",
	Scene.GROCERIES: "res://scenes/groceries/groceries.tscn",
	Scene.BUILD_ENCLOSURE: "res://scenes/build_enclosure/build_enclosure.tscn",
	Scene.SCIENTIST_ACTIONS: "res://scenes/scientist_actions/scientist_actions.tscn",
	Scene.INCUBATOR: "res://scenes/incubator/incubator.tscn",
	Scene.PLACE_EGG: "res://scenes/incubator/place_egg.tscn",
	Scene.MOVE_DINOSAUR: "res://scenes/dinos/move_dinosaur.tscn",
	Scene.DINOSAUR_CREATION_LINE: "res://scenes/scientist_actions/dinosaur_creation_line.tscn",
	Scene.FOOD_CREATION_LINE: "res://scenes/scientist_actions/food_creation_line.tscn",
	Scene.INGREDIENT: "res://scenes/scientist_actions/ingredient.tscn",
	Scene.INCUBATOREGG: "res://scenes/incubator/incubatoregg.tscn",
	Scene.INVENTORY: "res://scenes/inventory/inventory.tscn",
	Scene.INVENTORY_ITEM: "res://scenes/inventory/inventory_item.tscn",
	Scene.DINOSAUR_LINE: "res://scenes/dinos/dinosaur_line.tscn",
	Scene.GROCERY_ITEM: "res://scenes/groceries/grocery_item.tscn",
	Scene.SCIENTIST_RESUME: "res://scenes/resumes/scientist_resume.tscn",
	Scene.STAFF_RESUME: "res://scenes/resumes/staff_resume.tscn",
	Scene.RESUME_EGG: "res://scenes/resumes/resume_egg.tscn",
	Scene.RESUME_FOOD: "res://scenes/resumes/resume_egg.tscn",
	Scene.SCIENTIST_BUTTON: "res://scenes/science/scientist_button.tscn",
	Scene.BIRD_LINE: "res://scenes/birds/bird_line.tscn",
	Scene.BIOME_BUTTON: "res://scenes/build_enclosure/biome_button.tscn",
	Scene.FENCE_BUTTON: "res://scenes/build_enclosure/fence_button.tscn",
	Scene.MONEY_TAB: "res://scenes/money/money_tab.tscn",
	Scene.MONEY_LINE: "res://scenes/money/money_line.tscn",
}

