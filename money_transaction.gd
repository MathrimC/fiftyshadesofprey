class_name MoneyTransaction
extends Resource

enum Type { TICKET_SALES, SELL_EGG, SELL_DINOSAUR, WAGE, HIRE_COST, BUY_ENCLOSURE, BUY_GROCERIES, BUY_BIRDS }

@export var type: Type
@export var value: int
@export var label: String
@export var day: int

func _init(_type: Type = Type.TICKET_SALES, _value: int = 0, _label: String = "", _day: int = 0) -> void:
	type = _type
	value = _value
	label = _label
	day = _day
