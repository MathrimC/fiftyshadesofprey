class_name FenceButton
extends TextureButton

signal fence_selected(fence: Fence.Type)

var fence: Fence.Type

func _ready() -> void:
	self.texture_normal = game_manager.game_resources.get_fence(fence).icon
	self.texture_pressed = game_manager.game_resources.get_fence(fence).icon

func _pressed() -> void:
	fence_selected.emit(fence)
