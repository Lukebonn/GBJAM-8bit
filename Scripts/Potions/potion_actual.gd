extends Node2D
@export var potion_stats = PotionResource

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var inventory: InventoryComponent = $"../../UI/Inventory"
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var item_quantity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	sprite_2d.texture = potion_stats.sprite
	#print(potion_stats.rarity)
	
	#if item_quantity == 1:
		#label.visible = false
	#else: 
		#label.visible = true

func increase_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	label.text = String(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity += amount_to_remove
	label.text = String(item_quantity)

func set_position_in_slot(slot_size: Vector2) -> void:
	sprite_2d.position = slot_size


func _on_area_2d_body_entered(body: Node2D) -> void:
	#inventory.add_inventory_item(potion_stats)
	SignalBus.item_pickup.emit(potion_stats)
	sprite_2d.hide()
	#print(inventory.get_inventory_contents())
	collision_shape_2d.set_deferred("disabled", true)
