class_name FoodCreationLine
extends HBoxContainer

@export var food_icon: TextureRect
@export var ingredients_container: HBoxContainer
@export var button: TextureButton
@export var timer: RichTextLabel

var recipe: FoodRecipe
var scientist: Scientist.Type

func _ready() -> void:
	# food_icon.texture = load("%s/%s" % [Resources.food_textures_dir, Resources.food_textures[food]])
	food_icon.texture = game_manager.game_resources.get_food(recipe.outputs.keys()[0]).texture
	for ingredient in recipe.ingredients:
		var ingredient_ui = preload(Resources.scenes[Resources.Scene.INGREDIENT]).instantiate()
		ingredient_ui.amount.text = "%s x" % recipe.ingredients[ingredient]
		# ingredient_ui.ingredient.texture = load("%s/%s" % [Resources.grocery_textures_dir, Resources.grocery_textures[ingredient]])
		ingredient_ui.ingredient.texture = game_manager.game_resources.get_grocery(ingredient).texture
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
	while action_info["timer"].time_left > 0:
		var seconds: int = action_info["timer"].time_left
		var minutes := floori(seconds / 60.)
		seconds = seconds % 60
		timer.text = "%02d:%02d" % [minutes, seconds]
		await get_tree().create_timer(1).timeout
	var seconds: int = recipe.time
	var minutes := floori(seconds / 60.)
	seconds = seconds % 60
	timer.text = "%02d:%02d" % [minutes, seconds]

func disable_action() -> void:
	button.disabled = true

func _on_create_pressed() -> void:
	game_manager.create_food(recipe, scientist)
	
