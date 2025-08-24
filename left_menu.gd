extends VBoxContainer

@export var scene_button_group: ButtonGroup
var active_scene: Node

func _ready():
	scene_button_group.pressed.connect(on_pressed)
	game_manager.scene_switched.connect(on_scene_switched)

func on_scene_switched(scene_type: Resources.Scene, node: Node):
	for button in scene_button_group.get_buttons():
		if button.scene == scene_type:
			button.set_pressed_no_signal(true)
	active_scene = node
	# for button in scene_button_group.get_buttons():
		# if 

func on_pressed(button: SceneButton):
	if active_scene != null:
		active_scene.queue_free()
	active_scene = load(Resources.scenes[button.scene]).instantiate()
	get_tree().root.add_child(active_scene)
