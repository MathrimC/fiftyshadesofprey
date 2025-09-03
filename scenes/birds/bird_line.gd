class_name BirdLine
extends Control

@export var image: TextureRect
@export var name_label: Label
@export var amount_label: RichTextLabel
@export var pricetag: TextureRect

var bird: Bird.Type
var birds: Birds
var amount: int

func _ready() -> void:
	var bird_data := game_manager.game_resources.get_bird(bird)
	image.texture = bird_data.texture
	name_label.text = bird_data.name
	pricetag.texture = birds.pricetags.get(bird_data.price, null)

func _on_plus_pressed() -> void:
	amount += 1
	amount_label.text = "%s" % amount

func _on_minus_pressed() -> void:
	amount = max(0, amount - 1)
	amount_label.text = "%s" % amount

func clear():
	amount = 0
	amount_label.text = "0"
