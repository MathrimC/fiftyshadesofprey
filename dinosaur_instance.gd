class_name DinosaurInstance
extends Resource

enum Stage { EGG, ALIVE }
enum Mood { HAPPY, SAD, ANGRY }
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

