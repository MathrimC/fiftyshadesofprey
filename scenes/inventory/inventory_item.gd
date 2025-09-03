class_name InventoryItem
extends Control

@export var item_name: RichTextLabel
@export var icon: TextureRect
@export var amount_label: RichTextLabel

var type: GameManager.InventoryType
var item: int

func _ready() -> void:
	update()

func item_pressed() -> void:
	if type == GameManager.InventoryType.EGGS:
		game_manager.use_egg(item)
		update()

func update() -> void:
	var amount: int
	match type:
		GameManager.InventoryType.EGGS:
			var dinosaur_data := game_manager.game_resources.get_dinosaur(item as Dinosaur.Type)
			item_name.text = "%s egg" % dinosaur_data.name
			icon.texture = dinosaur_data.egg_texture
			# icon_path = "%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dino]["egg"]]
			amount = game_manager.get_egg_amount(dinosaur_data.type)
		GameManager.InventoryType.BIRDS:
			var bird_data: Bird = game_manager.game_resources.get_bird(item as Bird.Type)
			item_name.text = "%ss" % bird_data.name
			icon.texture = bird_data.texture
			# icon_path = "%s/%s" % [Resources.bird_textures_dir, Resources.bird_textures[bird]["icon"]]
			amount = game_manager.get_bird_amount(item as Bird.Type)
		GameManager.InventoryType.GROCERIES:
			var grocery_data: Grocery = game_manager.game_resources.get_grocery(item as Grocery.Type)
			item_name.text = "%s" % grocery_data.name
			icon.texture = grocery_data.texture
			# icon_path = "%s/%s" % [Resources.grocery_textures_dir, Resources.grocery_textures[grocery]]
			amount = game_manager.get_groceries_amount(item as Grocery.Type)
	if amount == 0:
		self.queue_free()
	else:
		amount_label.text = "%s" % amount
		# icon.texture = load(icon_path)
