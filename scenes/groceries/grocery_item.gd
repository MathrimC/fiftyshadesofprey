class_name GroceryItem
extends HBoxContainer

@export var price: TextureRect
@export var icon: TextureRect
@export var item_name: RichTextLabel
@export var amount_label: RichTextLabel

var grocery: Grocery
var amount: int

func _ready() -> void:
	amount = 0
	price.rotation_degrees = randf_range(-35, 35)
	icon.texture = grocery.texture
	# load("%s/%s" % [Resources.grocery_textures_dir, Resources.grocery_textures[grocery]])
	item_name.text = grocery.name
	# Resources.Groceries.keys()[grocery].capitalize()
	amount_label.text = "%s" % 0

func _on_plus_pressed() -> void:
	amount += 1
	amount_label.text = "%s" % amount

func _on_minus_pressed() -> void:
	amount = max(0, amount - 1)
	amount_label.text = "%s" % amount

func clear():
	amount = 0
	amount_label.text = "0"
