class_name DinosaurCreationLine
extends HBoxContainer

@export var egg: TextureRect
@export var bird_amount: RichTextLabel
@export var bird: TextureRect
@export var button: TextureButton
var dinosaur: Resources.Dinosaur

func _ready() -> void:
	button.disabled = false
	egg.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["egg"]])
	var birds_info: Dictionary = game_manager.dinosaur_info.get(dinosaur, {}).get("birds", {})
	# For now, there's only 1 bird per dinosaur
	for bird_type in birds_info:
		bird_amount.text = "%s x" % birds_info[bird_type]
		bird.texture = load("%s/%s" % [Resources.bird_textures_dir, Resources.bird_textures[bird_type]["icon"]])
		if game_manager.get_bird_amount(bird_type) < birds_info[bird_type]:
			button.disabled = true

func _on_create_pressed() -> void:
	game_manager.create_egg(dinosaur)
	game_manager.switch_scene(Resources.Scene.INCUBATOR)
