class_name Crafting_UI
extends PanelContainer

@export var inventory_slot : PackedScene = null
@export var recipe_array : Array[ItemRecipe] = []

@onready var tree: Tree = %Tree
@onready var title_label: Label = %TitleLabel
@onready var grid_container: GridContainer = %GridContainer
@onready var texture_rect: TextureRect = %TextureRect

var recipe_material_dictionary : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_recipe_tree()

#this populates the available recipes you can see
func build_recipe_tree() -> void:
	tree.hide_root = true
	var tree_root : TreeItem = tree.create_item()
	
	#this will populate it live/in game so it'll start empty in theory
	for recipe in recipe_array:
		var new_recipe_slot : TreeItem = tree.create_item(tree_root)
		new_recipe_slot.set_icon(0, recipe.recipe_output.sprite)
		new_recipe_slot.set_icon_max_width(0,5)
		new_recipe_slot.set_text(0, recipe.recipe_output.name)
		


func _on_tree_cell_selected() -> void:
	var cell_recipe_name : String = tree.get_selected().get_text(0)
	
	for recipe in recipe_array:
		if recipe.recipe_output.name == cell_recipe_name:
			build_recipe_material_window(recipe)
			return

func build_recipe_material_window(selected_recipe : ItemRecipe) -> void:
	title_label.text = selected_recipe.recipe_output.name
	texture_rect.texture = selected_recipe.recipe_output.sprite
	
	for recipe_material in selected_recipe.recipe_material_array:
		if recipe_material_dictionary.has(recipe_material):
			recipe_material_dictionary[recipe_material] += 1
		else:
			recipe_material_dictionary[recipe_material] = 1
