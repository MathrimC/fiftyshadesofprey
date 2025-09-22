class_name DinosaurCreationLine
extends HBoxContainer

@export var egg: TextureRect
@export var bird_amount: RichTextLabel
@export var bird_texture: TextureRect
@export var button: TextureButton
@export var timer: RichTextLabel
@export var available: Container
@export var unavailable: Container
@export var unavailable_image: TextureRect
var dinosaur: Dinosaur.Type
var scientist: Scientist.Type

func _ready() -> void:
	var dinosaur_data := game_manager.game_resources.get_dinosaur(dinosaur)
	egg.texture = dinosaur_data.egg_texture
	if game_manager.is_dinosaur_unlocked(dinosaur):
		if game_manager.is_dinosaur_known(dinosaur):
			egg.tooltip_text = dinosaur_data.name
		else:
			egg.tooltip_text = "???"
		var bird: Bird = game_manager.game_resources.get_bird(dinosaur_data.creation_bird)
		bird_amount.text = "1 x"
		bird_texture.texture = bird.texture
		bird_texture.visible = true
		bird_texture.tooltip_text = bird.name
		var seconds: int = dinosaur_data.creation_time
		var minutes := floori(seconds / 60.)
		seconds = seconds % 60
		timer.text = "%02d:%02d" % [minutes, seconds]
		refresh_button()
		available.show()
		unavailable.hide()
	else:
		egg.tooltip_text = "???"
		bird_amount.text = "1 x      ???   "
		bird_texture.visible = false
		var unlock_condition: String = "Needed to unlock:\n"
		for type in dinosaur_data.eggs_to_unlock:
			if game_manager.is_dinosaur_known(type):
				unlock_condition += "%s %s egg\n" % [dinosaur_data.eggs_to_unlock[type], game_manager.game_resources.get_dinosaur(dinosaur).name]
			else:
				unlock_condition += "%s ??? egg\n" % dinosaur_data.eggs_to_unlock[type]
		unavailable.tooltip_text = unlock_condition
		available.hide()
		unavailable.show()

func refresh_button() -> void:
	var bird := game_manager.game_resources.get_dinosaur(dinosaur).creation_bird
	button.disabled = (game_manager.get_bird_amount(bird) < 1)

func track_action_time(action_info: Dictionary) -> void:
	var end_time: int = action_info["end_time"]
	var time_left := end_time - roundi(Time.get_unix_time_from_system())
	while time_left > 0:
		var minutes_left := floori(time_left / 60.)
		var seconds_left := time_left % 60
		timer.text = "%02d:%02d" % [minutes_left, seconds_left]
		await get_tree().create_timer(0.1).timeout
		time_left = end_time - Time.get_unix_time_from_system() as int
	var seconds: int = game_manager.game_resources.get_dinosaur(dinosaur).creation_time
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]

func disable_action() -> void:
	button.disabled = true

func _on_create_pressed() -> void:
	game_manager.create_egg(dinosaur, scientist)
	
