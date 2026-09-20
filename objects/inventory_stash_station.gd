class_name InventoryBench
extends Area2D

@onready var crafting_ui: Crafting_UI = %"Crafting UI"
#@onready var player: PlayerEntity = $"../Player"
@onready var player: PlayerEntity = %Player
#@onready var inventory: InventoryComponent = $"../UI/Inventory"
@onready var inventory: InventoryComponent = %Inventory

var is_interactable : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerEntity:
		print("Player Entered")
		is_interactable = true
	#pass


func _on_body_exited(body: Node2D) -> void:
	if body is PlayerEntity:
		print("Player Exited")
		is_interactable = false
		inventory.hide()
	#pass

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("GB_SELECT") and is_interactable:
		if (inventory.visible == false):
			inventory.show()
		else:
			inventory.hide()
