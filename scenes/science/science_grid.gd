extends GridContainer

func _ready() -> void:
	for scientist in game_manager.get_hired_scientists():
		var texture_button := TextureButton.new()
		texture_button.texture_normal = load(Resources.scientist_textures_dir + "/" + Resources.scientist_textures[scientist]["icon"])
		add_child(texture_button)
		texture_button.pressed.connect(on_pressed)
	
func on_pressed() -> void:
	game_manager.switch_scene(Resources.Scene.SCIENTIST_ACTIONS)
