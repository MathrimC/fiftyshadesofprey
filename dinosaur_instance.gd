class_name DinosaurInstance
extends Resource

enum Stage { EGG, ALIVE }
enum Mood { HAPPY, SAD, HUNGRY, STARVING }
enum Genetics { GMO, NATURAL }

const egg_expiration_time := 15 * 60

@export var name: String
@export var type: Dinosaur.Type
@export var stage: Stage
@export var mood: Mood
@export var genetics: Genetics

@export var egg_creation_time: int
@export var egg_hatch_time: int

func get_egg_time_left() -> float:
	return egg_creation_time + egg_expiration_time - Time.get_unix_time_from_system()

func feed(has_food: bool) -> void:
	if has_food:
		for enclosure: Enclosure in game_manager.game_data.enclosures.values():
			if enclosure.dinosaurs.has(self):
				if enclosure.biome == game_manager.game_resources.get_dinosaur(type).biome:
					mood = Mood.HAPPY
				else:
					mood = Mood.SAD
				break
	elif !has_food:
		match mood:
			Mood.STARVING:
				# TODO:
				pass
			Mood.HUNGRY:
				mood = Mood.STARVING
			_:
				mood = Mood.HUNGRY
