class_name InvSlot
extends TextureRect

#@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var label : Label = $Label

@export var potion_held : PotionResource
var item_quantity = 0

func _ready() -> void:
	pass

func set_recipe_item_data(ItemData : PotionResource, StackSize : int) -> void:
	potion_held = ItemData
	#sprite_2d.texture = ItemData.sprite
	label.text = str(StackSize)
	item_quantity = StackSize

func increase_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	label.text = str(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	label.text = str(item_quantity)
	if item_quantity == 0:
		queue_free()
