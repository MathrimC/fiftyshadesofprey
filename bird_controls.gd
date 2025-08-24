class_name BirdControls
extends HBoxContainer

@export var bird: Resources.Bird
var amount_label: RichTextLabel
var amount: int

func _ready():
	amount_label = get_node("Amount/AmountLabel")

func _on_plus_pressed() -> void:
	amount += 1
	amount_label.text = "%s" % amount

func _on_minus_pressed() -> void:
	amount = max(0, amount - 1)
	amount_label.text = "%s" % amount
