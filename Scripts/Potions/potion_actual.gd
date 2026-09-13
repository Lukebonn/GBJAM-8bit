extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var potion_stats = Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	sprite_2d.texture = potion_stats.sprite
	print(potion_stats.rarity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_position_in_slot(slot_size: Vector2) -> void:
	sprite_2d.position = slot_size / 2
