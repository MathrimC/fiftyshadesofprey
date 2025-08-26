class_name DinosaurCreationLine
extends HBoxContainer

@export var egg: TextureRect
@export var bird_amount: RichTextLabel
@export var bird: TextureRect
@export var button: TextureButton
@export var timer: RichTextLabel
var dinosaur: Resources.Dinosaur
var scientist: Resources.Scientist

func _ready() -> void:
	egg.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["egg"]])
	var birds_info: Dictionary = game_manager.dinosaur_info.get(dinosaur, {}).get("birds", {})
	# For now, there's only 1 bird per dinosaur
	for bird_type in birds_info:
		bird_amount.text = "%s x" % birds_info[bird_type]
		bird.texture = load("%s/%s" % [Resources.bird_textures_dir, Resources.bird_textures[bird_type]["icon"]])
	var seconds: int = game_manager.dinosaur_info.get(dinosaur, {}).get("creation_time", 0)
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]
	refresh_button()

func refresh_button() -> void:
	button.disabled = false
	var birds_info: Dictionary = game_manager.dinosaur_info.get(dinosaur, {}).get("birds", {})
	# For now, there's only 1 bird per dinosaur
	for bird_type in birds_info:
		if game_manager.get_bird_amount(bird_type) < birds_info[bird_type]:
			button.disabled = true

func track_action_time(action_info: Dictionary) -> void:
	while action_info["timer"].time_left > 0:
		var seconds: int = action_info["timer"].time_left
		var minutes := floori(seconds / 60.)
		seconds = seconds % 60
		timer.text = "%02d:%02d" % [minutes, seconds]
		await get_tree().create_timer(1).timeout
	var seconds: int = game_manager.dinosaur_info.get(dinosaur, {}).get("creation_time", 0)
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]

func disable_action() -> void:
	button.disabled = true

func _on_create_pressed() -> void:
	game_manager.create_egg(dinosaur, scientist)
	
