class_name ParkLot
extends Sprite2D

@export var lot_number: int

func _ready() -> void:
	var enclosure := game_manager.get_lot_content(lot_number)
	if enclosure != null:
		self.texture = load("%s/%s" % [Resources.enclosure_textures_dir, Resources.enclosure_textures[enclosure.biome]])
