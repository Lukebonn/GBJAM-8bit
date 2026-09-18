class_name HUD
extends CanvasLayer

var gold : int = 0
var potion_count : int = 0

@onready var gold_label: Label = $Control/GoldLabel
@onready var potion_label: Label = $Control/PotionLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gold_label.text = str(gold) + " G"
	potion_label.text = str(potion_count)
