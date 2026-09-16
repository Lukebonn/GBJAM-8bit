class_name InventorySlot
extends Panel

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var item_quantity

func _ready() -> void:
	pass

func set_recipe_item_data(ItemData : PotionResource, StackSize : int) -> void:
	sprite_2d.texture = ItemData.sprite
	label.text = str(StackSize)

func increase_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	label.text = String(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity += amount_to_remove
	label.text = String(item_quantity)
