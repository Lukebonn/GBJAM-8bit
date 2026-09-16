@tool
class_name MenuTab
extends Control

@export var tab_spr : Sprite2D
@export var icon_spr : Sprite2D

@export var icon : Texture2D : 
	set(value):
		icon = value
		icon_spr.texture = value

var is_active_tab : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon_spr.texture = icon

func _process(delta: float) -> void:
	if !is_active_tab:
		tab_spr.frame = 1
		icon_spr.position = Vector2(7.0, 12.0)
	else:
		tab_spr.frame = 0
		icon_spr.position = Vector2(7.0, 9.0)
