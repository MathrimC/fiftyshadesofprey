extends TextureButton

func _on_pressed():
	game_manager.start_game()
	get_tree().change_scene_to_file(Resources.scenes[Resources.Scene.GAME])
