extends TextEdit

var max_scale: Vector2 = Vector2(1.2, 1.2)
var min_scale: Vector2 = Vector2(0.8, 0.8)
var duration: float = 2.0

func _ready() -> void:
	pivot_offset = size / 2.0
	enlarge_reduce()

func _input(event):
	if event is InputEventKey and event.pressed and not event.is_echo():
		NavigationManager.go_to_level("kitchen", "W")

func enlarge_reduce() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(self, "scale", max_scale, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", min_scale, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
