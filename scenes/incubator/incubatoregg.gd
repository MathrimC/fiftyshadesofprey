class_name Incubatoregg
extends Control

@export var egg: TextureRect
@export var biome: TextureRect
@export var food: TextureRect
@export var dino_name: Label
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
	biome.texture = game_manager.game_resources.get_biome(dinosaur_info.biome).icon
	dino_name.text = dinosaur_info.name
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
	# if _event is InputEventMouseButton && _event.button_index == MouseButton.MOUSE_BUTTON_LEFT && !_event.pressed:
	# game_manager.switch_scene(scene)
	var place_egg: PlaceEgg = load(Resources.scenes[Resources.Scene.PLACE_EGG]).instantiate()
	place_egg.dinosaur = dinosaur
	get_tree().root.add_child(place_egg)
	game_manager.register_scene_switch(Resources.Scene.PLACE_EGG, place_egg)
