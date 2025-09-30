class_name FenceButton
extends TextureButton

signal fence_selected(fence: Fence.Type)

@export var unpressed_color: Color
var fence: Fence.Type

func _ready() -> void:
	self.texture_normal = game_manager.game_resources.get_fence(fence).icon
	self.texture_pressed = game_manager.game_resources.get_fence(fence).icon
	self.button_group.pressed.connect(on_button_group_pressed)

func on_button_group_pressed(pressed_button: BaseButton) -> void:
	if pressed_button == self:
		# TODO: remove signal and use button group in parent
		fence_selected.emit(fence)
		self.modulate = Color.WHITE
	else:
		self.modulate = unpressed_color
