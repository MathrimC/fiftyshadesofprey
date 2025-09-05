class_name DinosaurTile
extends Node

@export var icon: TextureRect
@export var feeling: RichTextLabel
@export var biome: TextureRect
@export var food: TextureRect
@export var dino_name: Label

var dinosaur: DinosaurInstance

func _ready() -> void:
	var dinosaur_info: Dinosaur = game_manager.game_resources.get_dinosaur(dinosaur.type)
	# var dinosaur_info: Dictionary = game_manager.dinosaur_info.get(dinosaur, {})
	# icon.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["dino"]])
	icon.texture = dinosaur.texture
	feeling.text = GameManager.DinosaurFeeling.keys()[dinosaur_info.mood].capitalize()
	# TODO: set food texture
	match dinosaur_info.diet:
		Dinosaur.Diet.HERBIVORE:
			food.texture = game_manager.game_resources.get_food(Food.Type.HERBIVORE).texture
		Dinosaur.Diet.CARNIVORE:
			food.texture = game_manager.game_resources.get_food(Food.Type.CARNIVORE).texture
	biome.texture = game_manager.game_resources.get_biome(dinosaur.biome).texture
	# dino_name.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["name"]])
	dino_name.text = dinosaur_info.name
