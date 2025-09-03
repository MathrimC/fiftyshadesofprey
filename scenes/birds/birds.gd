class_name Birds
extends Control

@export var container: Container
@export var pricetags: Dictionary[int, Texture]
@export var lines: Array[BirdLine]

func _ready() -> void:
	for bird in Bird.Type.values():
		var line: BirdLine = preload(Resources.scenes[Resources.Scene.BIRD_LINE]).instantiate()
		line.bird = bird
		line.birds = self
		container.add_child(line)
		lines.append(line)

func _on_buy_pressed() -> void:
	var bird_amounts: Dictionary[Bird.Type, int]
	for line in lines:
		if line.amount > 0:
			bird_amounts[line.bird] = line.amount
		line.clear()
	game_manager.buy_birds(bird_amounts)
