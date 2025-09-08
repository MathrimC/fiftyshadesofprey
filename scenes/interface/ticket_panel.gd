extends PanelContainer

@export var ticket_slider: Slider
@export var ticket_input: LineEdit

func _enter_tree() -> void:
	self.hide()

func on_visibility_changed() -> void:
	refresh()

func refresh() -> void:
	ticket_slider.value = game_manager.game_data.ticket_price
	ticket_input.text = "%s" % game_manager.game_data.ticket_price
	print("refreshed")

func on_input_submitted(input: String) -> void:
	var value := input.to_int()
	if value > 0:
		value = min(value, 200)
		ticket_slider.value = value
		ticket_input.text = "%s" % value
	else:
		ticket_input.text = "%s" % (ticket_slider.value as int)

func on_value_changed(valuef: float) -> void:
	var value := valuef as int
	ticket_input.text = "%s" % value

func on_yay_pressed() -> void:
	game_manager.change_ticket_price(ticket_slider.value as int)
	self.hide()

func on_nay_pressed() -> void:
	self.hide()

	



