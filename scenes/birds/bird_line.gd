class_name BirdLine
extends Control

@export var image: TextureRect
@export var name_label: Label
@export var amount_label: RichTextLabel
# @export var pricetag: TextureRect
@export var pricetags: Array[TextureRect]

var bird: Bird.Type
var birds: Birds
var amount: int

func _ready() -> void:
	var bird_data := game_manager.game_resources.get_bird(bird)
	image.texture = bird_data.texture
	name_label.text = bird_data.name
	var pricetag := pricetags[bird % pricetags.size()]
	pricetag.show()
	pricetag.find_child("Price").text = "%s" % bird_data.price

func _on_plus_pressed() -> void:
	amount += 1
	amount_label.text = "%s" % amount

func _on_minus_pressed() -> void:
	amount = max(0, amount - 1)
	amount_label.text = "%s" % amount

func clear():
	amount = 0
	amount_label.text = "0"
