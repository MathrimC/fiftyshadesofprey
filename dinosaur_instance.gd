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
	if has_food && (mood == Mood.STARVING || mood == Mood.HUNGRY):
		# TODO: check enclosure for sadness
		mood = Mood.HAPPY
	else:
		match mood:
			Mood.STARVING:
				# TODO:
				pass
			Mood.HUNGRY:
				mood = Mood.STARVING
			_:
				mood = Mood.HUNGRY

