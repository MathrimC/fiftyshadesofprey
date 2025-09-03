class_name DinosaurCreationLine
extends HBoxContainer

@export var egg: TextureRect
@export var bird_amount: RichTextLabel
@export var bird_texture: TextureRect
@export var button: TextureButton
@export var timer: RichTextLabel
var dinosaur: Dinosaur.Type
var scientist: Scientist.Type

func _ready() -> void:
	egg.texture = load("%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dinosaur]["egg"]])
	var dinosaur_data := game_manager.game_resources.get_dinosaur(dinosaur)
	var bird: Bird = game_manager.game_resources.get_bird(dinosaur_data.creation_bird)
	bird_amount.text = "1 x"
	bird_texture.texture = bird.texture
	# bird_texture.texture = load("%s/%s" % [Resources.bird_textures_dir, Resources.bird_textures[bird]["icon"]])

	var seconds: int = dinosaur_data.creation_time
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]
	refresh_button()

func refresh_button() -> void:
	button.disabled = false
	var bird := game_manager.game_resources.get_dinosaur(dinosaur).creation_bird
	# For now, there's only 1 bird per dinosaur
	button.disabled = (game_manager.get_bird_amount(bird) < 1)

func track_action_time(action_info: Dictionary) -> void:
	while action_info["timer"].time_left > 0:
		var seconds: int = action_info["timer"].time_left
		var minutes := floori(seconds / 60.)
		seconds = seconds % 60
		timer.text = "%02d:%02d" % [minutes, seconds]
		await get_tree().create_timer(1).timeout
	var seconds: int = game_manager.game_resources.get_dinosaur(dinosaur).creation_time
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]

func disable_action() -> void:
	button.disabled = true

func _on_create_pressed() -> void:
	game_manager.create_egg(dinosaur, scientist)
	
