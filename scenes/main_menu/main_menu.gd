class_name MainMenu
extends Control

@export var continue_button: TextureButton

func _ready() -> void:
	continue_button.visible = FileAccess.file_exists(GameData.save_path)

func on_continue_pressed() -> void:
	game_manager.continue_game()

func on_new_game_pressed() -> void:
	game_manager.start_game()

func on_quit_pressed() -> void:
	get_tree().quit()
