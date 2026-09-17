class_name InventoryComponent
extends Node2D

@export var inventory_slot : PackedScene = null

@onready var grid_container: GridContainer = $GridContainer

var inventory_contents : Array[InventorySlot] = []

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_inventory_contents() -> Dictionary:
	var inventory_contents_dictionary : Dictionary = {}

	for item in inventory_contents:
		inventory_contents_dictionary[item.potion_held] = int(item.label.text)

	return inventory_contents_dictionary

func add_inventory_item(new_item : PotionResource) -> void:
	if inventory_contents.size() == 0:
		var new_material = inventory_slot.instantiate() as InventorySlot
		grid_container.add_child(new_material)
		new_material.set_recipe_item_data(new_item, 1)
		inventory_contents.append(new_material)
		return
	var i = 0
	for item in inventory_contents:
		if inventory_contents[i].potion_held == new_item:
			inventory_contents[i].increase_item_quantity(1)
			return
		i += 1
	var new_material = inventory_slot.instantiate() as InventorySlot
	grid_container.add_child(new_material)
	new_material.set_recipe_item_data(new_item, 1)
	inventory_contents.append(new_material)
	return

func remove_inventory_item(new_item : PotionResource, stack_size : int) -> void:
	var i = 0
	for item in inventory_contents:
		if inventory_contents[i].potion_held.name == new_item.name:
			#print("first check")
			if int(inventory_contents[i].label.text) > 1:
				#print("second check")
				inventory_contents[i].decrease_item_quantity(stack_size)
				return
			inventory_contents[i].queue_free()
			return
		i += 1
	print("Item " + new_item.name + " doesn't exist to be removed")
