extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _omn_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node("door_path") as Door
	NavigationManager.trigger_player_spawn(door.global_position, door.spawn_direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
