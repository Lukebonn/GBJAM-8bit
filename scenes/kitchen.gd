extends Node2D

@onready var theme: AudioStreamPlayer2D = %theme


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	theme.play()
