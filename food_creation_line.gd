class_name FoodCreationLine
extends HBoxContainer

@export var food_icon: TextureRect
@export var ingredients_container: HBoxContainer
@export var button: TextureButton
@export var timer: RichTextLabel

var food: Resources.Food
var scientist: Resources.Scientist

func _ready() -> void:
	food_icon.texture = load("%s/%s" % [Resources.food_textures_dir, Resources.food_textures[food]])
	var ingredients = game_manager.food_info.get(food, {}).get("ingredients", {})
	for ingredient in ingredients:
		var ingredient_ui = preload(Resources.scenes[Resources.Scene.INGREDIENT]).instantiate()
		ingredient_ui.amount.text = "%s x" % ingredients[ingredient]
		ingredient_ui.ingredient.texture = load("%s/%s" % [Resources.ingredient_textures_dir, Resources.ingredient_textures[ingredient]])
		ingredients_container.add_child(ingredient_ui)
		if game_manager.get_groceries_amount(ingredient) < ingredients[ingredient]:
			button.disabled = true
	var seconds: int = game_manager.food_info.get(food, {}).get("creation_time", 0)
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]
	refresh_button()

func refresh_button() -> void:
	button.disabled = false
	var ingredients = game_manager.food_info.get(food, {}).get("ingredients", {})
	for ingredient in ingredients:
		if game_manager.get_groceries_amount(ingredient) < ingredients[ingredient]:
			button.disabled = true

func track_action_time(action_info) -> void:
	while action_info["timer"].time_left > 0:
		var seconds: int = action_info["timer"].time_left
		var minutes := floori(seconds / 60.)
		seconds = seconds % 60
		timer.text = "%02d:%02d" % [minutes, seconds]
		await get_tree().create_timer(1).timeout
	var seconds: int = game_manager.food_info.get(food, {}).get("creation_time", 0)
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]

func disable_action() -> void:
	button.disabled = true

func _on_create_pressed() -> void:
	game_manager.create_food(food, scientist)
	
