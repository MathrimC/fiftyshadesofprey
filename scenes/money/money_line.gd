class_name MoneyLine
extends HBoxContainer

@export var label: Label
@export var value: Label

func set_content(_label: String, _value: int):
	label.text = _label
	value.text = "%s" % _value
