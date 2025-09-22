class_name SellPanel
extends PanelContainer

@export var sell_label: Label
var dinosaur: DinosaurInstance

func _ready() -> void:
	game_manager.sell_requested.connect(on_sell_requested)

func on_sell_requested(_dinosaur: DinosaurInstance) -> void:
	dinosaur = _dinosaur
	var dinosaur_data := game_manager.game_resources.get_dinosaur(dinosaur.type)
	var value := dinosaur_data.value
	if dinosaur.genetics == DinosaurInstance.Genetics.NATURAL:
		value *= 2
	sell_label.text = "Do you want to sell"
	sell_label.text += " %s" % dinosaur.name if !dinosaur.name.is_empty() else ""
	sell_label.text += " the %s" % dinosaur_data.name
	sell_label.text += " egg" if dinosaur.stage == DinosaurInstance.Stage.EGG else ""
	sell_label.text += " for %s?" % value
	self.show()

func on_yay_pressed() -> void:
	match dinosaur.stage:
		DinosaurInstance.Stage.EGG:
			if dinosaur.get_egg_time_left() > 0:
				game_manager.sell_egg(dinosaur)
		DinosaurInstance.Stage.ALIVE:
			game_manager.sell_dinosaur(dinosaur)
	self.hide()

func on_nay_pressed() -> void:
	self.hide()
