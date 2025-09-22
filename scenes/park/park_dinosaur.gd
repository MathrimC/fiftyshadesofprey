class_name ParkDinosaur
extends Sprite2D

const scale_factor: float = 1.3

@export var dino_menu: PopupMenu
@export var dino_info: Window
var dinosaur: DinosaurInstance
var showing_dino_info: bool

func set_dinosaur(dino: DinosaurInstance) -> void:
	dinosaur = dino
	var dinosaur_info := game_manager.game_resources.get_dinosaur(dinosaur.type)
	self.texture = dinosaur_info.texture
	self.scale = Vector2(dinosaur_info.scale, dinosaur_info.scale) * scale_factor

func clear_dinosaur() -> void:
	self.texture = null

func _unhandled_input(event: InputEvent) -> void:
	if self.is_visible_in_tree() && self.texture != null:
		if get_rect().has_point(to_local(get_global_mouse_position())):
			if event is InputEventMouseButton && event.pressed && (event.button_index == MOUSE_BUTTON_LEFT || event.button_index == MOUSE_BUTTON_RIGHT):
				dino_menu.position = event.position
				dino_menu.show()
			elif event is InputEventMouseMotion && !showing_dino_info:
				ui_manager.show_dino_info(dinosaur)
				# owner.owner.show_dino_info(dinosaur)
				showing_dino_info = true
				# dino_info.position = event.position
				# dino_info.show()
		elif showing_dino_info:
			ui_manager.hide_dino_info(dinosaur)
			# owner.owner.hide_dino_info(dinosaur)
			showing_dino_info = false
			# dino_info.hide()
		

func on_menu_id_pressed(id: int) -> void:
	match id:
		0:
			game_manager.feed_dinosaur(dinosaur)
		1:
			var move_dinosaur: MoveDinosaur = load(Resources.scenes[Resources.Scene.MOVE_DINOSAUR]).instantiate()
			move_dinosaur.dinosaur = dinosaur
			get_tree().root.add_child(move_dinosaur)
			game_manager.register_scene_switch(Resources.Scene.MOVE_DINOSAUR, move_dinosaur)
		2:
			game_manager.request_dinosaur_sale(dinosaur)
		3:
			game_manager.codex_requested.emit(dinosaur.type)
