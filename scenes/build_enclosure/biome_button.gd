class_name BiomeButton
extends TextureButton

signal biome_selected(biome: Dinosaur.Biome)

var biome: Dinosaur.Biome

func _ready() -> void:
	self.texture_normal = load("%s/%s" % [Resources.biome_textures_dir, Resources.biome_textures[biome]])

func _pressed() -> void:
	biome_selected.emit(biome)
