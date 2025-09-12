class_name Staff
extends Resource

enum Type { CAREGIVER, RUNNER, MECHANIC, EGG_VENDOR, SECURITY, RESTAURANT_WORKER, GIFT_SHOP_WORKER }

@export var name: String
@export var type: Type
@export var wage: int
@export var caregiver_enclosure_limit: int
@export var texture: Texture
