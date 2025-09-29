extends Node

@export var map: Map
# @export var biome_selection: Control
# @export var fence_selection: Control
@export var enclosure_selection: Control
@export var cost_label: Label
@export var yay_button: TextureButton
@export var disabled_color: Color

@export var biome_button_container: Container
@export var fence_button_container: Container

var selected_lot: int
var biome_selected: bool
var selected_biome: Biome.Type
var fence_selected: bool
var selected_fence: Fence.Type

func _ready() -> void:
	# biome_selection.hide()
	# fence_selection.hide()
	enclosure_selection.hide()
	map.lot_selected.connect(on_lot_selected)
	for biome in Biome.Type.values():
		var biome_button: BiomeButton = preload(SceneManager.scenes[SceneManager.Scene.BIOME_BUTTON]).instantiate()
		biome_button.biome = biome
		biome_button.biome_selected.connect(on_biome_selected)
		biome_button_container.add_child(biome_button)
	for fence in Fence.Type.values():
		var fence_button: FenceButton = preload(SceneManager.scenes[SceneManager.Scene.FENCE_BUTTON]).instantiate()
		fence_button.fence = fence
		fence_button.fence_selected.connect(on_fence_selected)
		fence_button_container.add_child(fence_button)

func on_lot_selected(lot_number: int) -> void:
	if game_manager.is_lot_occupied(lot_number):
		return
	selected_lot = lot_number
	biome_selected = false
	fence_selected = false
	enclosure_selection.show()
	_refresh_enclosure_selection()

func on_biome_selected(biome: Biome.Type) -> void:
	biome_selected = true
	selected_biome = biome
	_refresh_enclosure_selection()
	# biome_selection.hide()
	# fence_selection.show()

func on_fence_selected(fence: Fence.Type) -> void:
	fence_selected = true
	selected_fence = fence
	_refresh_enclosure_selection()
	# game_manager.create_enclosure(selected_lot, selected_biome, fence)
	# fence_selection.hide()
	# map.refresh()

func on_nay_pressed() -> void:
	enclosure_selection.hide()

func on_yay_pressed() -> void:
	game_manager.create_enclosure(selected_lot, selected_biome, selected_fence)
	enclosure_selection.hide()
	map.refresh()

func _refresh_enclosure_selection() -> void:
	var cost: int = 0
	if biome_selected:
		cost += game_manager.game_resources.get_biome(selected_biome).cost
	if fence_selected:
		cost += game_manager.game_resources.get_fence(selected_fence).cost
	var has_money: bool = (game_manager.game_data.money >= cost)
	cost_label.text = "%s" % cost
	cost_label.modulate = Color.WHITE if has_money else Color.RED
	if biome_selected && fence_selected && has_money:
		yay_button.disabled = false
		yay_button.modulate = Color.WHITE
	else:
		yay_button.disabled = true
		yay_button.modulate = disabled_color
