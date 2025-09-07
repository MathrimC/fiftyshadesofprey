extends Button

func _ready() -> void:
	self.visible = FileAccess.file_exists(GameData.save_path)

func _on_pressed() -> void:
	game_manager.continue_game()
