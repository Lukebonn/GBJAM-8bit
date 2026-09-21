class_name InventorySlot
extends Panel

@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var label : Label = $Label

var potion_held : PotionResource
var item_quantity = 0

func _ready() -> void:
	pass

func set_recipe_item_data(ItemData : PotionResource, StackSize : int) -> void:
	potion_held = ItemData
	sprite_2d.texture = ItemData.sprite
	label.text = str(StackSize)
	item_quantity = StackSize
	if potion_held.item_category == potion_held.Item_Category.INGREDIENT:
		sprite_2d.scale = Vector2(1.0, 1.0)
	elif potion_held.item_category == potion_held.Item_Category.POTION:
		sprite_2d.scale = Vector2(0.08, 0.08)

func increase_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	label.text = str(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	label.text = str(item_quantity)
	#if item_quantity == 0:
		#queue_free()


func _on_button_pressed() -> void:
	if (potion_held):
		SignalBus.emit(potion_held)
	else: 
		print("no potion in this slot for some reason. I didn't think empty inventory_slots could exist.")

func destroy() -> void:
	queue_free()

func hide_panel() -> void:
	$".".hide()

func show_panel() -> void:
	$".".show()
