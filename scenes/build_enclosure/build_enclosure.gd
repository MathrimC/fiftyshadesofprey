extends Node

@export var map: Map
@export var biome_selection: Control
@export var fence_selection: Control

@export var biome_button_container: Container

var selected_lot: int
var selected_biome: Enclosure.Biome

func _ready() -> void:
	biome_selection.hide()
	fence_selection.hide()
	map.lot_selected.connect(on_lot_selected)
	for biome in Dinosaur.Biome.values():
		var biome_button: BiomeButton = preload(Resources.scenes[Resources.Scene.BIOME_BUTTON]).instantiate()
		biome_button.biome = biome
		biome_button.biome_selected.connect(on_biome_selected)
		biome_button_container.add_child(biome_button)

func on_lot_selected(lot_number: int) -> void:
	if game_manager.is_lot_occupied(lot_number):
		return
	selected_lot = lot_number
	biome_selection.show()

func on_biome_selected(biome: Enclosure.Biome) -> void:
	selected_biome = biome
	biome_selection.hide()
	fence_selection.show()

func on_enclosure_selected(fence: Enclosure.Fence) -> void:
	game_manager.create_enclosure(selected_lot, selected_biome, fence)
	fence_selection.hide()
	map.refresh()
