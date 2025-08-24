extends Node2D

func _on_buy_pressed() -> void:
	var bird_amounts: Dictionary
	for child in self.get_children():
		if child is BirdControls:
			bird_amounts[child.bird] = child.amount
	game_manager.buy_birds(bird_amounts)
