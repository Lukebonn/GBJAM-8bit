class_name CraftingBench
extends Area2D

@export var inventory_slot : PackedScene = null
@export var recipe_array : Array[ItemRecipe] = []

@onready var crafting_ui: Crafting_UI = %"Crafting UI"
@onready var player: PlayerEntity = %Player
@onready var inventory: InventoryComponent = %Inventory
@onready var label: Label = $Label

@onready var item_crafted: CanvasLayer = $ItemCrafted
@onready var panel: Panel = $ItemCrafted/Panel
@onready var slot_1: InventorySlot = $ItemCrafted/Slot1

@onready var one_ingredient_ui: CanvasLayer = $OneIngredientUI
@onready var panel_2: Panel = $OneIngredientUI/Panel2
@onready var slot_2: InventorySlot = $OneIngredientUI/Slot2

@onready var two_ingredient_ui: CanvasLayer = $TwoIngredientUI
@onready var panel_3: Panel = $TwoIngredientUI/Panel3
@onready var slot_3: InventorySlot = $TwoIngredientUI/Slot3
@onready var slot_4: InventorySlot = $TwoIngredientUI/Slot4

@onready var three_ingredient_ui: CanvasLayer = $ThreeIngredientUI
@onready var panel_4: Panel = $ThreeIngredientUI/Panel4
@onready var slot_5: InventorySlot = $ThreeIngredientUI/Slot5
@onready var slot_6: InventorySlot = $ThreeIngredientUI/Slot6
@onready var slot_7: InventorySlot = $ThreeIngredientUI/Slot7


const POTION_1 = preload("uid://cpjnwjxvilulc")
@onready var potion_pickups: Node = $"../../PotionPickups"

var crafting_item_pickup : PotionResource
var recipe1_item_pickup : PotionResource
var recipe1_num : int = 0
var recipe2_item_pickup : PotionResource
var recipe2_num : int = 0
var recipe3_item_pickup : PotionResource
var recipe3_num : int = 0
var num_recipe_items : int = 0
var is_interactable : bool = false
var recipe_material_dictionary : Dictionary = {}
#var player : PlayerEntity = null

func _ready() -> void:
	#SignalBus.item_dropped.connect(_on_potion_dropped)
	#SignalBus.item_pickup.connect(_on_potion_pickup)
	SignalBus.item_crafted.connect(_on_item_crafted)
	#SignalBus.potion_station_interact.connect(_on_potion_station_interact)
	clear_recipe_UI()

func _process(delta: float) -> void:
	if num_recipe_items > 0 and crafting_item_pickup == null:
		for recipe in recipe_array:
			if check_recipe_craftable(recipe):
				break

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerEntity:
		is_interactable = true
		player = body
	#pass

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerEntity:
		is_interactable = false
		crafting_ui.hide()
	#pass

func _unhandled_input(event : InputEvent) -> void:
	#print("button pushed")
	if event.is_action_pressed("GB_SELECT") and is_interactable:
		#for the player to pickup a successfully crafted item
		if crafting_item_pickup and player.inventory_potion == null:
			SignalBus.item_pickup.emit(crafting_item_pickup)
			#player.inventory_potion = crafting_item_pickup
			crafting_item_pickup = null
			clear_recipe_UI()
			
		#for the player to place an item into a recipe
		elif not crafting_item_pickup and player.inventory_potion:
			var held : PotionResource = player.inventory_potion
			var already_on_bench : bool = is_on_bench(held)
			if num_recipe_items == 3 and not already_on_bench:
				label.show()
				label.text = "Max recipe items reached"
				await get_tree().create_timer(2.5).timeout
				label.hide()
			else:
				if not already_on_bench:
					if num_recipe_items == 0:
						recipe1_item_pickup = held
						recipe1_num = 1
					elif num_recipe_items == 1:
						recipe2_item_pickup = held
						recipe2_num = 1
					elif num_recipe_items == 2:
						recipe3_item_pickup = held
						recipe3_num = 1
				SignalBus.item_dropped.emit(held)
				add_recipe_item_UI(held)
		#for the player to pickup a recipe item
		elif crafting_item_pickup == null and player.inventory_potion == null:
			if num_recipe_items == 3:
				#recipe3_num -= 1
				SignalBus.item_pickup.emit(recipe3_item_pickup)
				remove_recipe_item_UI(recipe3_item_pickup)
				#if recipe3_num == 0:
					#recipe3_item_pickup = null
			elif num_recipe_items == 2:
				SignalBus.item_pickup.emit(recipe2_item_pickup)
				remove_recipe_item_UI(recipe2_item_pickup)
			elif num_recipe_items == 1:
				SignalBus.item_pickup.emit(recipe1_item_pickup)
				remove_recipe_item_UI(recipe1_item_pickup)
			elif num_recipe_items == 0:
				label.show()
				label.text = "No items to pickup"
				await get_tree().create_timer(2.5).timeout
				label.hide()
		else: 
			if num_recipe_items == 0:
				print("no items to pickup")
			elif num_recipe_items == 1:
				SignalBus.item_pickup
	elif event.is_action_pressed("GB_SELECT") and not is_interactable and player.inventory_potion:
		var new_potion = POTION_1.instantiate()
		potion_pickups.add_child(new_potion)
		new_potion.create_instantiated_potion(player.global_position, player.inventory_potion)
		player.sprite_2d.texture = null
		player.inventory_potion = null
		
	await get_tree().create_timer(1).timeout
func _on_item_crafted(item : PotionResource) -> void:
	print("item crafted")
	clear_recipe_UI()
	crafting_item_pickup = item
	item_crafted.show()
	slot_1.show()
	#panel.bg_color = Color(1, 0, 0)
	#panel.bg_color = Color(34, 139, 34)
	slot_1.set_recipe_item_data(crafting_item_pickup, 1)

#func _on_potion_dropped(item : PotionResource) -> void:
	#if is_interactable:
		#add_recipe_item_UI(item)

#func _on_potion_pickup(item : PotionResource) -> void:
	#if is_interactable:
		#clear_recipe_UI()
		#if crafting_item_pickup:
			#add_recipe_item_UI(item)
		#elif num_recipe_items == 0:
			#label.show()
			#label.text = "Crafting bench empty"
			#await get_tree().create_timer(2.5).timeout
			#label.hide()
		#else:
			#remove_recipe_item_UI(item)

#func _on_potion_station_interact(item : PotionResource) -> void:
	#player

func add_recipe_item_UI(item : PotionResource) -> void:
	if num_recipe_items == 0:
		one_ingredient_ui.show()
		slot_2.show()
		slot_2.set_recipe_item_data(recipe1_item_pickup, 1)
		num_recipe_items += 1
	
	elif num_recipe_items == 1:
		if item.name == recipe1_item_pickup.name:
			recipe1_num += 1
			slot_2.increase_item_quantity(1)
			return
		else:
			one_ingredient_ui.hide()
			slot_2.hide()
			two_ingredient_ui.show()
			slot_3.show()
			slot_4.show()
			#slot_3 = slot_2
			slot_3.set_recipe_item_data(recipe1_item_pickup, recipe1_num)
			slot_4.set_recipe_item_data(recipe2_item_pickup, 1)
			num_recipe_items += 1
	
	elif num_recipe_items == 2:
		if item.name == recipe1_item_pickup.name:
			recipe1_num += 1
			slot_3.increase_item_quantity(1)
		elif item.name == recipe2_item_pickup.name:
			recipe2_num += 1
			slot_4.increase_item_quantity(1)
		else:
			two_ingredient_ui.hide()
			slot_3.hide()
			slot_4.hide()
			three_ingredient_ui.show()
			slot_5.show()
			slot_6.show()
			slot_7.show()
			#slot_5 = slot_3
			#slot_6 = slot_4
			slot_5.set_recipe_item_data(recipe1_item_pickup, recipe1_num)
			slot_6.set_recipe_item_data(recipe2_item_pickup, recipe2_num)
			slot_7.set_recipe_item_data(recipe3_item_pickup, 1)
			num_recipe_items += 1
	
	elif num_recipe_items == 3:
		if item.name == recipe1_item_pickup.name:
			recipe1_num += 1
			slot_5.increase_item_quantity(1)
		elif item.name == recipe2_item_pickup.name:
			recipe2_num += 1
			slot_6.increase_item_quantity(1)
		elif item.name == recipe3_item_pickup.name:
			recipe3_num += 1
			slot_7.increase_item_quantity(1)
		else:
			label.show()
			label.text = "too many ingredients"
			await get_tree().create_timer(2.5).timeout
			label.hide()

func remove_recipe_item_UI(item : PotionResource) -> void:
	if num_recipe_items == 0:
		label.show()
		label.text = "Not enough ingredients"
		await get_tree().create_timer(2.5).timeout
		label.hide()
	
	elif num_recipe_items == 1:
		if item.name == recipe1_item_pickup.name:
			recipe1_num -= 1
			slot_1.decrease_item_quantity(1)
			if recipe1_num == 0:
				recipe1_item_pickup = null
				slot_2.hide()
				one_ingredient_ui.hide()
				num_recipe_items -= 1
	elif num_recipe_items == 2:
		recipe2_num -= 1
		slot_4.decrease_item_quantity(1)
		if recipe2_num == 0:
			recipe2_item_pickup = null
			slot_3.hide()
			slot_4.hide()
			two_ingredient_ui.hide()
			slot_2.show()
			one_ingredient_ui.show()
			num_recipe_items -= 1
			slot_2.set_recipe_item_data(recipe1_item_pickup, recipe1_num)
	elif num_recipe_items == 3:
		recipe3_num -= 1
		slot_7.decrease_item_quantity(1)
		if recipe3_num == 0:
			recipe3_item_pickup = null
			slot_5.hide()
			slot_6.hide()
			slot_7.hide()
			three_ingredient_ui.hide()
			slot_3.show()
			slot_4.show()
			two_ingredient_ui.show()
			num_recipe_items -= 1
			slot_3.set_recipe_item_data(recipe1_item_pickup, recipe1_num)
			slot_4.set_recipe_item_data(recipe2_item_pickup, recipe2_num)

func clear_recipe_UI() -> void:
	crafting_item_pickup = null
	recipe1_item_pickup = null
	recipe2_item_pickup = null
	recipe3_item_pickup = null
	one_ingredient_ui.hide()
	two_ingredient_ui.hide()
	two_ingredient_ui.hide()
	item_crafted.hide()
	slot_1.hide()
	slot_2.hide()
	slot_3.hide()
	slot_4.hide()
	slot_5.hide()
	slot_6.hide()
	slot_7.hide()
	panel.hide()
	panel_2.hide()
	panel_3.hide()
	panel_4.hide()
	recipe1_num = 0
	recipe2_num = 0
	recipe3_num = 0
	num_recipe_items = 0

#create a dictionary of items currently in the pot for smaller search function
func get_bench_contents() -> Dictionary:
	var contents : Dictionary = {}
	var items := [recipe1_item_pickup, recipe2_item_pickup, recipe3_item_pickup]
	var counts := [recipe1_num, recipe2_num, recipe3_num]
	for i in items.size():
		if items[i] != null and counts[i] > 0:
			contents[items[i].name] = contents.get(items[i].name, 0) + counts[i]
	return contents

#what a recipe needs, in the same shape
func get_recipe_requirements(recipe : ItemRecipe) -> Dictionary:
	var required : Dictionary = {}
	for recipe_material in recipe.recipe_material_array:
		if recipe_material != null:
			required[recipe_material.name] = required.get(recipe_material.name, 0) + 1
	return required

#current items cooking in the pot
func is_on_bench(item : PotionResource) -> bool:
	for bench_item in [recipe1_item_pickup, recipe2_item_pickup, recipe3_item_pickup]:
		if bench_item != null and bench_item.name == item.name:
			return true
	return false


func check_recipe_craftable(recipe : ItemRecipe) -> bool:
	if get_bench_contents() != get_recipe_requirements(recipe):
		return false
	SignalBus.item_crafted.emit(recipe.recipe_output)
	return true
