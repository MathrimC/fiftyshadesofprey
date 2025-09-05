class_name BiomeButton
extends TextureButton

signal biome_selected(biome: Biome.Type)

var biome: Biome.Type

func _ready() -> void:
	self.texture_normal = game_manager.game_resources.get_biome(biome).icon

func _pressed() -> void:
	biome_selected.emit(biome)
