class_name MapLot
extends TextureButton

static var highlight_color: Color = Color(0,1,0,0.9)
static var disabled_highlight_color: Color = Color(1,0,0,0.3)

@export var lot_number: int
@export var enclosure_info: Container
@export var biome: TextureRect
@export var dinosaur_1: TextureRect
@export var dinosaur_2: TextureRect
var mode: Map.Mode

func _ready() -> void:
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	owner.refresh_requested.connect(refresh)
	mode = owner.mode
	refresh()

func refresh() -> void:
	var enclosure := game_manager.get_lot_content(lot_number)
	var game_resources := game_manager.game_resources
	if enclosure != null:
		biome.texture = game_resources.get_biome(enclosure.biome).icon
		if !enclosure.dinosaurs.is_empty():
			dinosaur_1.texture = game_resources.get_dinosaur(enclosure.dinosaurs[0].type).texture
		else:
			dinosaur_1.texture = null
		if enclosure.dinosaurs.size() > 1:
			dinosaur_2.texture = game_resources.get_dinosaur(enclosure.dinosaurs[1].type).texture
		else:
			dinosaur_2.texture = null
		enclosure_info.show()
	else:
		enclosure_info.hide()
	match mode:
		Map.Mode.VIEW:
			self.disabled = true
		Map.Mode.BUILD_ENCLOSURE:
			self.disabled = (enclosure != null)
		Map.Mode.PLACE_EGG, Map.Mode.MOVE_DINOSAUR:
			self.disabled = (enclosure == null || enclosure.is_full())

func _pressed() -> void:
	owner.select_lot(lot_number)

func _on_mouse_entered() -> void:
	if mode != Map.Mode.VIEW:
		if !self.disabled:
			self.self_modulate = highlight_color
		else:
			self.self_modulate = disabled_highlight_color

func _on_mouse_exited() -> void:
	if mode != Map.Mode.VIEW:
		self.self_modulate = Color.WHITE
