class_name DinosaurTile
extends Node

@export var icon: TextureRect
@export var feeling: RichTextLabel
@export var biome: TextureRect
@export var food: TextureRect
@export var dino_name: TextureRect

var dinosaur_data: Dictionary

func _ready() -> void:
	var dinosaur: Resources.Dinosaur = dinosaur_data["dinosaur"]
	var dinosaur_info: Dictionary = game_manager.dinosaur_info.get(dinosaur, {})
	icon.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["dino"]])
	feeling.text = GameManager.DinosaurFeeling.keys()[dinosaur_data["feeling"]].capitalize()
	food.texture = load("%s/%s" % [Resources.food_textures_dir, Resources.food_textures[dinosaur_info["food"]]])
	biome.texture = load("%s/%s" % [Resources.biome_textures_dir, Resources.biome_textures[dinosaur_info["biome"]]])
	dino_name.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["name"]])
