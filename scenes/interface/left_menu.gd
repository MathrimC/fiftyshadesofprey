extends VBoxContainer

@export var scene_button_group: ButtonGroup

var backpack: Backpack

func _ready():
	scene_button_group.pressed.connect(on_pressed)
	game_manager.scene_switched.connect(on_scene_switched)
	game_manager.codex_requested.connect(on_codex_requested)
	game_manager.switch_scene(Resources.Scene.DINOPARK)

func on_scene_switched(scene_type: Resources.Scene, _node: Node):
	for button in scene_button_group.get_buttons():
		if button.scene == scene_type:
			button.set_pressed_no_signal(true)

func on_pressed(button: SceneButton):
	game_manager.switch_scene(button.scene)

func on_backpack_pressed() -> void:
	if backpack == null:
		backpack = preload(Resources.scenes[Resources.Scene.BACKPACK]).instantiate()
		owner.add_child(backpack)
	else:
		backpack.queue_free()

func on_codex_requested(dinosaur: Dinosaur.Type) -> void:
	if backpack == null:
		backpack = preload(Resources.scenes[Resources.Scene.BACKPACK]).instantiate()
		owner.add_child(backpack)
	backpack.open_dino(dinosaur)
