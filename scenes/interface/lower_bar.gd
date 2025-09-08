class_name LowerBar
extends TextureRect

@export var notification_label: RichTextLabel
@export var ticket_label: RichTextLabel
@export var money_label: RichTextLabel
@export var ticket_panel: Container

func _ready():
	game_manager.notification.connect(on_notification)
	game_manager.money_changed.connect(on_money_changed)
	game_manager.ticket_price_changed.connect(on_ticket_price_changed)
	ticket_label.text = "%s" % game_manager.game_data.ticket_price
	money_label.text = "%s" % game_manager.game_data.money

func on_ticket_price_pressed() -> void:
	ticket_panel.show()

func on_notification(_notification: String) -> void:
	notification_label.text = _notification

func on_money_changed(_money: int) -> void:
	money_label.text = "%s" % _money

func on_ticket_price_changed(_price: int) -> void:
	ticket_label.text = "%s" % _price
