class_name FoodCreationLine
extends HBoxContainer

@export var food_icon: TextureRect
@export var ingredients_container: HBoxContainer
@export var button: TextureButton
@export var timer: RichTextLabel

var recipe: FoodRecipe
var scientist: Scientist.Type

func _ready() -> void:
	var food := game_manager.game_resources.get_food(recipe.outputs.keys()[0])
	food_icon.texture = food.texture
	food_icon.tooltip_text = food.name
	for ingredient in recipe.ingredients:
		var ingredient_ui = preload(Resources.scenes[Resources.Scene.INGREDIENT]).instantiate()
		ingredient_ui.amount.text = "%s x" % recipe.ingredients[ingredient]
		var grocery := game_manager.game_resources.get_grocery(ingredient)
		ingredient_ui.ingredient.texture = grocery.texture
		ingredient_ui.ingredient.tooltip_text = grocery.name
		ingredients_container.add_child(ingredient_ui)
		if game_manager.get_groceries_amount(ingredient) < recipe.ingredients[ingredient]:
			button.disabled = true
	var seconds: int = recipe.time
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]
	refresh_button()

func refresh_button() -> void:
	button.disabled = false
	for ingredient in recipe.ingredients:
		if game_manager.get_groceries_amount(ingredient) < recipe.ingredients[ingredient]:
			button.disabled = true

func track_action_time(action_info) -> void:
	var end_time: int = action_info["end_time"]
	var time_left := end_time - Time.get_unix_time_from_system() as int
	while time_left > 0:
		var minutes_left := floori(time_left / 60.)
		var seconds_left := time_left % 60
		timer.text = "%02d:%02d" % [minutes_left, seconds_left]
		await get_tree().create_timer(0.1).timeout
		time_left = end_time - Time.get_unix_time_from_system() as int
	var seconds: int = recipe.time
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]

func disable_action() -> void:
	button.disabled = true

func _on_create_pressed() -> void:
	game_manager.create_food(recipe, scientist)
	
