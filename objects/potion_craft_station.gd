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
	#SignalBus.item_crafted.connect(_on_item_crafted)
	#SignalBus.potion_station_interact.connect(_on_potion_station_interact)
	clear_recipe_UI()

func _process(delta: float) -> void:
	#just a heads up as the # of recipes increase this for loop might put strain on RAM lol
	if (num_recipe_items > 1) and crafting_item_pickup == null:
		for recipe in recipe_array:
			check_recipe_craftable(recipe)

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerEntity:
		print("Player Entered")
		is_interactable = true
		player = body
	#pass

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerEntity:
		print("Player Exited")
		is_interactable = false
		crafting_ui.hide()
	#pass

func _unhandled_input(event : InputEvent) -> void:
	#print("button pushed")
	if event.is_action_pressed("GB_SELECT") and is_interactable:
		print("button pushed and interactable")
		#for the player to pickup a successfully crafted item
		if crafting_item_pickup and player.inventory_potion == null:
			player.inventory_potion = crafting_item_pickup
			crafting_item_pickup = null
			
		#for the player to place a an item into a recipe
		elif not crafting_item_pickup and player.inventory_potion:
			if num_recipe_items == 3:
				if recipe3_item_pickup.name == player.inventory_potion.name:
					recipe1_num += 1
				elif recipe2_item_pickup.name == player.inventory_potion.name:
					recipe2_num += 1
				elif recipe1_item_pickup.name == player.inventory_potion.name:
					recipe3_num += 1
				else:
					label.show()
					label.text = "Max recipe items reached"
					await get_tree().create_timer(2.5).timeout
					label.hide()
			elif num_recipe_items == 2:
				if recipe2_item_pickup.name != player.inventory_potion.name and recipe1_item_pickup.name != player.inventory_potion.name:
					recipe3_item_pickup = player.inventory_potion
				#recipe3_num += 1
				SignalBus.item_dropped.emit(recipe3_item_pickup)
				add_recipe_item_UI(recipe3_item_pickup)
			elif num_recipe_items == 1:
				if recipe1_item_pickup.name != player.inventory_potion.name:
					recipe2_item_pickup = player.inventory_potion
				recipe2_num += 1
				SignalBus.item_dropped.emit(recipe2_item_pickup)
				add_recipe_item_UI(recipe2_item_pickup)
			elif num_recipe_items == 0:
				recipe1_item_pickup = player.inventory_potion
				recipe1_num += 1
				SignalBus.item_dropped.emit(recipe1_item_pickup)
				add_recipe_item_UI(recipe1_item_pickup)
		#for the player to pickup a recipe item
		elif crafting_item_pickup == null and player.inventory_potion == null:
			if num_recipe_items == 3:
				recipe3_num -= 1
				SignalBus.item_pickup.emit(recipe3_item_pickup)
				remove_recipe_item_UI(recipe3_item_pickup)
				if recipe3_num == 0:
					recipe3_item_pickup = null
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
	await get_tree().create_timer(1).timeout
#func _on_item_crafted(item : PotionResource) -> void:
	#clear_recipe_UI()
	#crafting_item_pickup = item
	#item_crafted.show()
	##panel.bg_color = Color(1, 0, 0)
	#panel.bg_color = Color(34, 139, 34)
	#slot_1.set_recipe_item_data(crafting_item_pickup, 1)

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
		print(recipe1_item_pickup.name)
		print(slot_2.potion_held.name)
		num_recipe_items += 1
	
	elif num_recipe_items == 1:
		if item.name == recipe1_item_pickup.name:
			recipe1_num += 1
			slot_2.increase_item_quantity(1)
			return
		else:
			print("increase slots")
			one_ingredient_ui.hide()
			slot_2.hide()
			two_ingredient_ui.show()
			slot_3.show()
			slot_4.show()
			#slot_3 = slot_2
			slot_3.set_recipe_item_data(recipe1_item_pickup, 1)
			slot_4.set_recipe_item_data(recipe2_item_pickup, 1)
			print(recipe1_item_pickup.name)
			print(recipe2_item_pickup.name)
			print(slot_3.potion_held.name)
			print(slot_4.potion_held.name)
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
			print(recipe1_item_pickup.name)
			print(recipe2_item_pickup.name)
			print(recipe3_item_pickup.name)
			print(slot_5.potion_held.name)
			print(slot_6.potion_held.name)
			print(slot_7.potion_held.name)
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
			return
		else:
			one_ingredient_ui.hide()
			recipe1_item_pickup = null
	
	elif num_recipe_items == 2:
		if item.name == recipe1_item_pickup.name:
			recipe1_num -= 1
			slot_3.decrease_item_quantity(1)
			if recipe1_num == 0:
				recipe1_item_pickup = null
		elif item.name == recipe2_item_pickup.name:
			recipe2_num -= 1
			slot_4.decrease_item_quantity(1)
			if recipe2_num == 0:
				recipe2_item_pickup = null
		else:
			two_ingredient_ui.hide()
			one_ingredient_ui.show()
			slot_2 = slot_3
			recipe2_item_pickup = null
	
	elif num_recipe_items == 3:
		if item.name == recipe1_item_pickup.name:
			recipe1_num -= 1
			slot_5.decrease_item_quantity(1)
			if recipe1_num == 0:
				recipe1_item_pickup = null
		elif item.name == recipe2_item_pickup.name:
			recipe2_num += 1
			slot_6.decrease_item_quantity(1)
			if recipe2_num == 0:
				recipe2_item_pickup = null
		elif item.name == recipe3_item_pickup.name:
			recipe3_num += 1
			slot_7.decrease_item_quantity(1)
			if recipe3_num == 0:
				recipe3_item_pickup = null
		else:
			three_ingredient_ui.hide()
			two_ingredient_ui.show()
			slot_3 = slot_5
			slot_4 = slot_6
			recipe3_item_pickup = null

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


func check_recipe_craftable(recipe) -> void:
	var total_keys : int = 0
	for key in recipe_material_dictionary:
		total_keys += recipe_material_dictionary[key]
	for recipe_material in recipe:
		if recipe_material_dictionary.has(recipe_material):
			recipe_material_dictionary[recipe_material] += 1
		else:
			recipe_material_dictionary[recipe_material] = 1
	var materials = 0
	for material in recipe_material_dictionary:
		if recipe1_item_pickup:
			if material.name == recipe1_item_pickup.name:
				if recipe1_num < recipe_material_dictionary[material]:
					materials += 1
					break
		elif recipe2_item_pickup:
			if material.name == recipe2_item_pickup.name:
				if recipe2_num < recipe_material_dictionary[material]:
					materials += 1
					break
		elif recipe3_item_pickup:
			if material.name == recipe3_item_pickup.name:
				if recipe3_num < recipe_material_dictionary[material]:
					materials += 1
					break
	if materials == total_keys:
		SignalBus.item_crafted.emit(recipe.recipe_output)
