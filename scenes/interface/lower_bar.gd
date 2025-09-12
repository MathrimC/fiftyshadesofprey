class_name LowerBar
extends TextureRect

@export var notification_label: RichTextLabel
@export var notification_player: AnimationPlayer
@export var ticket_label: RichTextLabel
@export var money_label: RichTextLabel
@export var ticket_panel: Container

var notification_action: Callable = func (_parameter: Variant): pass
var notification_action_argument: Variant

func _ready():
	game_manager.notification.connect(on_notification)
	game_manager.money_changed.connect(on_money_changed)
	game_manager.ticket_price_changed.connect(on_ticket_price_changed)
	ticket_label.text = "%s" % game_manager.game_data.ticket_price
	money_label.text = "%s" % game_manager.game_data.money

func on_ticket_price_pressed() -> void:
	ticket_panel.show()

func on_notification(_notification: String, _action: Callable, _action_argument: Variant = null) -> void:
	notification_action = _action
	notification_action_argument = _action_argument
	notification_label.text = _notification
	for i in 3:
		notification_player.queue("new_notification")
	
func on_notification_pressed() -> void:
	notification_player.stop()
	notification_action.call(notification_action_argument)
	notification_label.text = ""
	notification_action = func (_parameter: Variant): pass

func on_money_changed(_money: int) -> void:
	money_label.text = "%s" % _money

func on_ticket_price_changed(_price: int) -> void:
	ticket_label.text = "%s" % _price
