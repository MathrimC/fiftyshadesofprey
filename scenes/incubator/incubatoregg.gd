class_name Incubatoregg
extends Control

@export var egg: TextureRect
@export var biome: TextureRect
@export var food: TextureRect
@export var dino_name: TextureRect
@export var timer: RichTextLabel

var dinosaur: DinosaurInstance

func _ready() -> void:
	var dinosaur_info: Dinosaur = game_manager.game_resources.get_dinosaur(dinosaur.type)
	# egg.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["egg"]])
	egg.texture = dinosaur_info.egg_texture
	match dinosaur_info.diet:
		Dinosaur.Diet.HERBIVORE:
			food.texture = game_manager.game_resources.get_food(Food.Type.HERBIVORE).texture
		Dinosaur.Diet.CARNIVORE:
			food.texture = game_manager.game_resources.get_food(Food.Type.CARNIVORE).texture
	# food.texture = load("%s/%s" % [Resources.food_textures_dir, Resources.food_textures[dinosaur_info["food"]]])
	biome.texture = load("%s/%s" % [Resources.biome_textures_dir, Resources.biome_textures[dinosaur_info.biome]])
	# TODO: replace with name label
	dino_name.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur.type]["name"]])
	_timer()

func _timer() -> void:
	var seconds: int = dinosaur.get_egg_time_left()
	while seconds > 0:
		var minutes := floori(seconds / 60.)
		seconds = seconds % 60
		timer.text = "Expires in %02d:%02d" % [minutes, seconds]
		await get_tree().create_timer(1).timeout
		seconds = dinosaur.get_egg_time_left()
	timer.text = "Egg hatched!"

func on_place_clicked() -> void:
	#open map
	pass
