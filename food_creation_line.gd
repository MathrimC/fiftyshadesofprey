class_name FoodCreationLine
extends HBoxContainer

@export var food_icon: TextureRect
@export var ingredients_container: HBoxContainer
@export var button: TextureButton

var food: Resources.Food

func _ready() -> void:
	food_icon.texture = load("%s/%s" % [Resources.food_textures_dir, Resources.food_textures[food]])
	var ingredients = game_manager.food_info.get(food, {}).get("ingredients", {})
	for ingredient in ingredients:
		var ingredient_ui = preload(Resources.scenes[Resources.Scene.INGREDIENT]).instantiate()
		ingredient_ui.amount.text = "%s x" % ingredients[ingredient]
		ingredient_ui.ingredient.texture = load("%s/%s" % [Resources.ingredient_textures_dir, Resources.ingredient_textures[ingredient]])
		ingredients_container.add_child(ingredient_ui)
