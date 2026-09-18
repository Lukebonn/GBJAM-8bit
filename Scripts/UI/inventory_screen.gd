extends Control

@export var menu : Control

@export var inventory_slot : PackedScene = null
@export var cursor : AnimatedSprite2D

@onready var grid_container: GridContainer = $GridContainer

var inventory_contents : Array[InvSlot] = []

var default_cursor_pos : Vector2

var cursor_index : int = 0

func _ready() -> void:
	
	if inventory_contents == []:
		cursor.position = Vector2(16, 48)
	else:
		
		cursor.position = inventory_contents[cursor_index].position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cursor_index < 0:
		cursor_index = max(cursor_index, 0)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		cursor_index -= 1
	elif event.is_action_pressed("right"):
		cursor_index += 1
	elif event.is_action_pressed("up"):
		cursor_index -= 7
	elif event.is_action_pressed("down"):
		cursor_index += 7
	
	if cursor_index >= 0 and cursor_index < menu.inv.inventory_contents.size():
		move_cursor(cursor_index)
	elif cursor_index < 0:
		cursor_index = 0
	elif cursor_index > menu.inv.inventory_contents.size():
		cursor_index = menu.inv.inventory_contents.size()

func move_cursor(index : int) -> void:
	cursor.position = inventory_contents[index].position

#func get_inventory_contents() -> Dictionary:
	#var inventory_contents_dictionary : Dictionary = {}
#
	#for item in inventory_contents:
		#inventory_contents_dictionary[item.potion_held] = int(item.label.text)
#
	#return inventory_contents_dictionary
#
#func add_inventory_item(new_item : PotionResource) -> void:
	#if inventory_contents.size() == 0:
		#var new_material = inventory_slot.instantiate() as InventorySlot
		#grid_container.add_child(new_material)
		#new_material.set_recipe_item_data(new_item, 1)
		#inventory_contents.append(new_material)
		#return
	#var i = 0
	#for item in inventory_contents:
		#if inventory_contents[i].potion_held == new_item:
			#inventory_contents[i].increase_item_quantity(1)
			#return
		#i += 1
	#var new_material = inventory_slot.instantiate() as InventorySlot
	#grid_container.add_child(new_material)
	#new_material.set_recipe_item_data(new_item, 1)
	#inventory_contents.append(new_material)
	#return
#
#func remove_inventory_item(new_item : PotionResource, stack_size : int) -> void:
	#var i = 0
	#for item in inventory_contents:
		#if inventory_contents[i].potion_held.name == new_item.name:
			##print("first check")
			#if int(inventory_contents[i].label.text) > 1:
				##print("second check")
				#inventory_contents[i].decrease_item_quantity(stack_size)
				#return
			#inventory_contents[i].queue_free()
			#return
		#i += 1
	#print("Item " + new_item.name + " doesn't exist to be removed")
