extends Area2D

@export var active: Texture2D
@export var inactive: Texture2D
@export var scene: Resources.Scene

@export var sprite: Sprite2D

func on_mouse_entered() -> void:
	sprite.texture = active

func on_mouse_exited() -> void:
	sprite.texture = inactive

func on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event is InputEventMouseButton && _event.button_index == MouseButton.MOUSE_BUTTON_LEFT && !_event.pressed:
		if scene == Resources.Scene.STAFF_OVERVIEW:
			var resumes: StaffOverview = load(Resources.scenes[Resources.Scene.STAFF_OVERVIEW]).instantiate()
			resumes.context = StaffOverview.Context.RESUMES
			resumes.page = StaffOverview.Page.SCIENTISTS
			get_tree().root.add_child(resumes)
			game_manager.register_scene_switch(scene, resumes)
		else:	
			game_manager.switch_scene(scene)
