class_name BiomeButton
extends TextureButton

signal biome_selected(biome: Biome.Type)

@export var unpressed_color: Color
var biome: Biome.Type

func _ready() -> void:
	self.texture_normal = game_manager.game_resources.get_biome(biome).icon
	self.texture_pressed = game_manager.game_resources.get_biome(biome).icon
	self.button_group.pressed.connect(on_button_group_pressed)


func on_button_group_pressed(pressed_button: BaseButton) -> void:
	if pressed_button == self:
		# TODO: remove signal and use button group in parent
		biome_selected.emit(biome)
		self.modulate = Color.WHITE
	else:
		self.modulate = unpressed_color

