extends Node2D
@export var potion_stats : PotionResource
@export var sprite_2d = Sprite2D

@onready var label: Label = $Label
@onready var inventory: InventoryComponent = $"../../UI/Inventory"
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var item_quantity
var standing_on_potion : bool = false
@onready var player: PlayerEntity = %Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = potion_stats.sprite
	#SignalBus.item_pickup_option_on.connect(_on_item_pickup_option_on)
	#SignalBus.item_pickup_option_off.connect(_on_item_pickup_option_off)

func increase_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	label.text = String(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity += amount_to_remove
	label.text = String(item_quantity)

func set_position_in_slot(slot_size: Vector2) -> void:
	sprite_2d.position = slot_size

#func _on_item_pickup_option_on() -> void: 
	#standing_on_potion = true 
	#print("standing")
	#await get_tree().create_timer(.1).timeout
#func _on_item_pickup_option_off() -> void: 
	#standing_on_potion = false
	#print("not standing")
	#await get_tree().create_timer(.1).timeout

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerEntity:
		print("player entered potion aura")
		print(player)
		standing_on_potion = true 
		#SignalBus.item_pickup_option_on.emit()
		#SignalBus.item_pickup.emit(potion_stats)
	#print(inventory.get_inventory_contents())
	#collision_shape_2d.set_deferred("disabled", true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is PlayerEntity:
		standing_on_potion = false 
		#SignalBus.item_pickup_option_off.emit()

func _unhandled_input(event : InputEvent) -> void:
	#print("button pushed")
	if event.is_action_pressed("GB_SELECT") and standing_on_potion:
		SignalBus.item_pickup.emit(potion_stats)
		queue_free()

func create_instantiated_potion(position_new: Vector2, item : PotionResource) -> void:
	print("instantiate")
	potion_stats = item
	global_position = Vector2(position_new.x, position_new.y + 15)
	sprite_2d.texture = item.sprite
	
	print("Actual global position: ", global_position)
	print("Sprite texture: ", sprite_2d.texture)
	print("Visible: ", visible)
	print("Sprite visible: ", sprite_2d.visible)
	print("In scene tree: ", is_inside_tree())
	print("Parent: ", get_parent())
	print("Local position: ", position)
	print("Sprite local position: ", sprite_2d.position)
	print("Sprite global position: ", sprite_2d.global_position)
