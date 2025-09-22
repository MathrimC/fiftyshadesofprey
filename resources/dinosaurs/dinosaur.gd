class_name Dinosaur
extends Resource

enum Type { DIPLODOCUS, STYRACOSAURUS, SPINOSAURUS, ANKYLOSAURUS, PTERANODON, VELOCIRAPTOR, PARASAUROLOPHUS, ALLOSAURUS, TRICERATOPS, IGUANADON, BRACHIOSAURUS, STEGOSAURUS, TYRANNOSAURUS_REX, HERRERASAURUS, CARNOTAURUS, KENTROSAURUS, PACHYCEPHALOSAURUS, DILOPHOSAURUS, OVIRAPTOR, PROTOCERATOPS }
enum Diet { HERBIVORE, CARNIVORE, OMNIVORE }

@export var type: Type
@export var name: String
@export var diet: Diet
@export var biome: Biome.Type
@export var description: String
@export var value: int
@export var visitors: int
@export var creation_bird: Bird.Type
@export var creation_chance: float
@export var creation_time: int
@export var eggs_to_unlock: Dictionary[Type, int]

@export var texture: Texture2D
@export var scale: float
@export var egg_texture: Texture2D
