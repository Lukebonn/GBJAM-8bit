extends Resource
class_name PotionResource

@export var item_category: Item_Category
@export var sprite: Texture2D

@export var rarity: Rarity
@export var ingredient_hierarchy: int
@export var name: String
@export var description: String

#uncomment if there ends being a need for a real need for different stack size
#@export var stack_size: int 

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	VERY_RARE,
	LEGENDARY
}

enum Item_Category {
	POTION,
	INGREDIENT
}

#rarity directly related to price not production cost
##common
##uncommon
##rare
##very rare
##Legenndary
#ingredient hierarchy count -- directly related to production cost
##1-5 (would require 2^5 -1 = 31 total items) 5 is high production cost 1 is low production cost (0 is ingredient)
#name -- string
#description 
## file location of a string instead
