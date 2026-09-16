class_name CraftingBench
extends Area2D

var is_interactable : bool = false

func _on_body_entered(body: Node2D) -> void:
	#if body is PlayerEntity:
		#print("Player Entered")
		#is_interactable = true
	pass


func _on_body_exited(body: Node2D) -> void:
	#if body is PlayerEntity:
		#print("Player Exited")
		#is_interactable = false
	pass
