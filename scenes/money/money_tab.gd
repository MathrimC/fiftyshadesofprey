class_name MoneyTab
extends MarginContainer

enum Type { DAY, TOTAL }

@export var type: Type
@export var income_container: Container
@export var expenses_container: Container
@export var profit: Label

var money_lines: Array[MoneyLine]

func _ready() -> void:
	match type:
		Type.DAY:
			name = "Day"
		Type.TOTAL:
			name = "Total"
	_refresh()

func _on_visibility_changed() -> void:
	_refresh()

func _refresh() -> void:
	for line in money_lines:
		line.queue_free()
	money_lines.clear()
	var type_totals: Dictionary[MoneyTransaction.Type, int]
	for i in range(game_manager.game_data.money_transactions.size() - 1, -1, -1):
		var transaction := game_manager.game_data.money_transactions[i]
		if type == Type.DAY && transaction.day < game_manager.game_data.day - 1:
			break
		type_totals[transaction.type] = type_totals.get(transaction.type, 0) + transaction.value

	var total := 0
	var ticket_sales: int = type_totals.get(MoneyTransaction.Type.TICKET_SALES, 0)
	_create_money_line("Tickets", ticket_sales, income_container)
	total += ticket_sales
	if type_totals.has(MoneyTransaction.Type.SELL_EGG):
		var egg_sales: int = type_totals[MoneyTransaction.Type.SELL_EGG]
		_create_money_line("Sold eggs", egg_sales, income_container)
		total += egg_sales
	if type_totals.has(MoneyTransaction.Type.SELL_DINOSAUR):
		var dinosaur_sales: int = type_totals[MoneyTransaction.Type.SELL_DINOSAUR]
		_create_money_line("Sold dinosaurs", dinosaur_sales, income_container)
		total += dinosaur_sales

	var wages: int = type_totals.get(MoneyTransaction.Type.WAGE, 0)
	total -= wages
	_create_money_line("Wages", wages, expenses_container)
	if type_totals.has(MoneyTransaction.Type.BUY_BIRDS):
		var buy_birds: int = type_totals[MoneyTransaction.Type.BUY_BIRDS]
		_create_money_line("Bought birds", buy_birds, expenses_container)
		total -= buy_birds
	if type_totals.has(MoneyTransaction.Type.BUY_GROCERIES):
		var buy_groceries: int = type_totals[MoneyTransaction.Type.BUY_GROCERIES]
		_create_money_line("Bought groceries", buy_groceries, expenses_container)
		total -= buy_groceries
	if type_totals.has(MoneyTransaction.Type.BUY_ENCLOSURE):
		var buy_enclosures: int = type_totals[MoneyTransaction.Type.BUY_ENCLOSURE]
		_create_money_line("Bought enclosures", buy_enclosures, expenses_container)
		total -= buy_enclosures
	
	profit.text = "%s" % total


func _create_money_line(label: String, value: int, container: Container):
	var money_line: MoneyLine = preload(SceneManager.scenes[SceneManager.Scene.MONEY_LINE]).instantiate()
	money_line.set_content(label, value)
	container.add_child(money_line)
	money_lines.append(money_line)
