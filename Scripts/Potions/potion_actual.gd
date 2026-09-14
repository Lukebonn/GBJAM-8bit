extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var potion_stats = PotionResource
@onready var label: Label = $Label

var item_quantity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	sprite_2d.texture = potion_stats.sprite
	print(potion_stats.rarity)
	
	if item_quantity == 1:
		label.visible = false
	else: 
		label.visible = true

func increase_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	label.text = String(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity += amount_to_remove
	label.text = String(item_quantity)

func set_position_in_slot(slot_size: Vector2) -> void:
	sprite_2d.position = slot_size / 2
