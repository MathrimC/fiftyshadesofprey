class_name Incubatoregg
extends Control

signal sell_pressed(incubatoregg: Incubatoregg)

@export var egg: TextureRect
@export var biome: TextureRect
@export var food: TextureRect
@export var dino_name: Label
@export var timer: RichTextLabel
@export var place_button: Button
@export var sell_button: Button
@export var trash_button: Button
@export var expiration_color: Color

var dinosaur: DinosaurInstance

func _ready() -> void:
	var dinosaur_info: Dinosaur = game_manager.game_resources.get_dinosaur(dinosaur.type)
	egg.texture = dinosaur_info.egg_texture
	match dinosaur_info.diet:
		Dinosaur.Diet.HERBIVORE:
			food.texture = game_manager.game_resources.get_food(Food.Type.HERBIVORE).texture
		Dinosaur.Diet.CARNIVORE:
			food.texture = game_manager.game_resources.get_food(Food.Type.CARNIVORE).texture
	biome.texture = game_manager.game_resources.get_biome(dinosaur_info.biome).icon
	dino_name.text = dinosaur_info.name
	trash_button.hide()
	_timer()

func _timer() -> void:
	var time_left: float = dinosaur.get_egg_time_left()
	while time_left > 0:
		var minutes := floori(time_left / 60.)
		var seconds := time_left as int % 60
		timer.text = "Expires in %02d:%02d" % [minutes, seconds]
		await get_tree().create_timer(0.1).timeout
		time_left = dinosaur.get_egg_time_left()
		egg.self_modulate = lerp(Color.WHITE, expiration_color, clamp(1 - (time_left / 10.), 0, 1))
	timer.text = "Egg expired!"
	egg.self_modulate = expiration_color
	place_button.hide()
	sell_button.hide()
	trash_button.show()

func on_place_pressed() -> void:
	var place_egg: PlaceEgg = load(Resources.scenes[Resources.Scene.PLACE_EGG]).instantiate()
	place_egg.dinosaur = dinosaur
	get_tree().root.add_child(place_egg)
	game_manager.register_scene_switch(Resources.Scene.PLACE_EGG, place_egg)

func on_sell_pressed() -> void:
	sell_pressed.emit(self)

func on_trash_pressed() -> void:
	game_manager.delete_egg(dinosaur)
	self.queue_free()
