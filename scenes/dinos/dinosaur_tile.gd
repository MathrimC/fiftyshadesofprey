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
	# food.texture = load("%s/%s" % [Resources.food_textures_dir, Resources.food_textures[dinosaur_info["food"]]])
	biome.texture = load("%s/%s" % [Resources.biome_textures_dir, Resources.biome_textures[dinosaur.biome]])
	# dino_name.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["name"]])
	dino_name.text = dinosaur_info.name
