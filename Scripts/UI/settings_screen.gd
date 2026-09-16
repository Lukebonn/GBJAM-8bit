extends Control

@onready var check_button: CheckButton = $NinePatchRect/VBoxContainer/CheckButton
@onready var button: Button = $NinePatchRect/VBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_button_pressed() -> void:
	get_tree().quit()
