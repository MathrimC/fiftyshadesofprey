class_name DinosaurLine
extends HBoxContainer

signal sell_pressed(dinosaur_line: DinosaurLine)
signal rename_pressed(dinosaur_line: DinosaurLine)

var dinosaur: DinosaurInstance

@onready var image: TextureRect = get_node("Image")
@onready var dino_name: Label = get_node("Name")
@onready var type: Label = get_node("Type")
@onready var mood: Label = get_node("Mood")
@onready var actions_button: Button = get_node("ActionsButton")
@onready var actions_menu: PopupMenu = get_node("ActionsMenu")

func _ready() -> void:
	actions_menu.hide()
	refresh()

func refresh() -> void:
	var dinosaur_data := game_manager.game_resources.get_dinosaur(dinosaur.type)
	image.texture = dinosaur_data.texture
	dino_name.text = dinosaur.name
	type.text = dinosaur_data.name
	mood.text = DinosaurInstance.Mood.keys()[dinosaur.mood].capitalize()

func on_actions_pressed() -> void:
	if !actions_menu.visible:
		actions_menu.position = actions_button.global_position + Vector2(0,actions_button.size.y)
		actions_menu.show()
	else:
		actions_menu.hide()

func on_action_id_pressed(id: int) -> void:
	match id:
		0:
			rename_pressed.emit(self)
		1:
			var move_dinosaur: MoveDinosaur = load(SceneManager.scenes[SceneManager.Scene.MOVE_DINOSAUR]).instantiate()
			move_dinosaur.dinosaur = dinosaur
			get_tree().root.add_child(move_dinosaur)
			scene_manager.register_scene_switch(SceneManager.Scene.MOVE_DINOSAUR, move_dinosaur)
		2:
			game_manager.request_dinosaur_sale(dinosaur)
		3:
			game_manager.codex_requested.emit(dinosaur.type)
