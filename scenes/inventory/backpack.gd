class_name Backpack
extends PanelContainer

@export var titlebar: TitleBar
@export var title: Label
@export var inventory: Control
@export var dinocodex: Control

func _ready() -> void:
	inventory.show()
	dinocodex.hide()
	titlebar.move_panel.connect(on_move_panel)
	scene_manager.scene_switched.connect(on_scene_switched)

func open_dino(dinosaur: Dinosaur.Type) -> void:
	title.text = "Dino Codex"
	dinocodex.go_to_dino(dinosaur)
	inventory.hide()
	dinocodex.show()
	

func on_move_panel(movement: Vector2):
	self.position += movement

func on_scene_switched(_scene: SceneManager.Scene, _node: Node):
	self.queue_free()

func on_inventory_pressed() -> void:
	title.text = "Inventory"
	inventory.show()
	dinocodex.hide()

func on_dinocodex_pressed() -> void:
	title.text = "Dino Codex"
	inventory.hide()
	dinocodex.show()

func on_close_pressed() -> void:
	self.queue_free()
