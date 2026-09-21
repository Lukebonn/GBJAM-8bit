extends TextureRect

var just_joined : bool = false

func _ready() -> void:
	just_joined = false
	await get_tree().create_timer(2.5).timeout
	just_joined = true

#func _process(delta: float) -> void:
	#if Input.is_anything_pressed() and just_joined:
		#NavigationManager.go_to_level("kitchen", "W")
