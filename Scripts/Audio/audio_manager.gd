extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.item_crafted.connect(_on_item_crafted)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_item_crafted(item : PotionResource) -> void:
	pass
	
