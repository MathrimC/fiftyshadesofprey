class_name Incubatoregg
extends Control

@export var egg: TextureRect
@export var biome: TextureRect
@export var food: TextureRect
@export var dino_name: TextureRect
@export var timer: RichTextLabel

var egg_info: Dictionary

func _ready() -> void:
	var dinosaur: Resources.Dinosaur = egg_info["dinosaur"]
	var dinosaur_info: Dictionary = game_manager.dinosaur_info.get(dinosaur, {})
	egg.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["egg"]])
	food.texture = load("%s/%s" % [Resources.food_textures_dir, Resources.food_textures[dinosaur_info["food"]]])
	biome.texture = load("%s/%s" % [Resources.biome_textures_dir, Resources.biome_textures[dinosaur_info["biome"]]])
	dino_name.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["name"]])
	_timer()

func _timer() -> void:
	var seconds: int = egg_info["timer"].time_left
	while seconds > 0:
		var minutes := floori(seconds / 60.)
		seconds = seconds % 60
		timer.text = "%02d:%02d" % [minutes, seconds]
		await get_tree().create_timer(1).timeout
		seconds = egg_info["timer"].time_left
