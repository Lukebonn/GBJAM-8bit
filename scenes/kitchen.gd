extends Node2D

@onready var theme: AudioStreamPlayer2D = %theme
#@onready var sub_viewport: SubViewport = $SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	theme.play()
	#sub_viewport.position = Vector2(200, 150)
