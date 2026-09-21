extends Node

const scene_kitchen = preload('res://scenes/kitchen.tscn')
const scene_world = preload("res://scenes/world.tscn")
const CREDITS = preload("uid://dhj70bvf5lsbu")

# const scene_bedroom = preload("res://path/to/bedroom.tscn")

#var spawn_door_tag
signal on_trigger_player_spawn


func go_to_level(level_tag : String, destination_tag: String):
	var scene_to_load
	
	match level_tag:
		"kitchen":
			scene_to_load = scene_kitchen
		"world":
			scene_to_load = scene_world
		"credits":
			scene_to_load = CREDITS
			
	if scene_to_load != null:
		#spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)


func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
