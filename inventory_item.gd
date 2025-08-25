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
	var icon_path: String
	var amount: int
	match type:
		GameManager.InventoryType.EGGS:
			var dino: Resources.Dinosaur = item as Resources.Dinosaur
			item_name.text = "%s egg" % Resources.Dinosaur.keys()[dino].capitalize()
			icon_path = "%s/%s" % [Resources.dinosaur_textures_dir, Resources.dinosaur_textures[dino]["egg"]]
			amount = game_manager.get_egg_amount(dino)
		GameManager.InventoryType.BIRDS:
			var bird: Resources.Bird = item as Resources.Bird
			item_name.text = "%ss" % Resources.Bird.keys()[bird].capitalize()
			icon_path = "%s/%s" % [Resources.bird_textures_dir, Resources.bird_textures[bird]["icon"]]
			amount = game_manager.get_bird_amount(bird)
		GameManager.InventoryType.GROCERIES:
			var grocery: Resources.Groceries = item as Resources.Groceries
			item_name.text = "%s" % Resources.Groceries.keys()[grocery].capitalize()
			icon_path = "%s/%s" % [Resources.ingredient_textures_dir, Resources.ingredient_textures[grocery]]
			amount = game_manager.get_groceries_amount(grocery)
	if amount == 0:
		self.queue_free()
	else:
		amount_label.text = "%s" % amount
		icon.texture = load(icon_path)
