extends Node2D

@onready var player: PlayerEntity = %Player
@onready var camera: Camera2D = $Player/Camera2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const SCREEN_SIZE := Vector2(160, 144)
const SCROLL_TIME := 0.6 
const LAND_MARGIN := 24.0  
const EDGE_PADDING := 4.0 

var scrolling := false
var exits := {}

func _ready() -> void:

	camera.top_level = true
	camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT   
	camera.position_smoothing_enabled = false
	camera.global_position = Vector2.ZERO                
	
	audio_stream_player_2d.play()
	
	_register_exit($Doors/Door_SE, Vector2.RIGHT)   
	_register_exit($Garden/Door_SW, Vector2.LEFT)   
	_register_exit($Doors/Door_NE, Vector2.UP)       
	
	_register_exit(_make_trigger(Rect2(0, -14, 160, 14)), Vector2.DOWN)  

func _register_exit(door: Area2D, dir: Vector2) -> void:
	if door == null:
		push_warning("scroll door not found - check the node path in _ready()")
		return
	var scene_door := door as Door
	if scene_door and door.body_entered.is_connected(scene_door._on_body_entered):
		door.body_entered.disconnect(scene_door._on_body_entered)
	exits[door] = dir

func _make_trigger(rect: Rect2) -> Area2D:
	var area := Area2D.new()
	var box := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = rect.size
	box.shape = shape
	area.position = rect.get_center()
	area.add_child(box)
	add_child(area)
	return area

func _physics_process(_delta: float) -> void:
	if scrolling:
		return
	var screen := Rect2(camera.global_position, SCREEN_SIZE).grow(-EDGE_PADDING)
	player.global_position = player.global_position.clamp(screen.position, screen.end)
	var push := Input.get_vector("left", "right", "up", "down")
	for door: Area2D in exits:
		var dir: Vector2 = exits[door]
		if push.dot(dir) > 0.5 and door.overlaps_body(player):
			scroll_screen(dir)
			return

func scroll_screen(dir: Vector2) -> void:
	scrolling = true
	player.set_process(false)
	player.velocity = Vector2.ZERO

	var cam_start := camera.global_position
	var cam_end := cam_start + dir * SCREEN_SIZE

	var landing := player.global_position
	if dir.x > 0: landing.x = cam_end.x + LAND_MARGIN
	elif dir.x < 0: landing.x = cam_end.x + SCREEN_SIZE.x - LAND_MARGIN
	if dir.y > 0: landing.y = cam_end.y + LAND_MARGIN
	elif dir.y < 0: landing.y = cam_end.y + SCREEN_SIZE.y - LAND_MARGIN

	var tween := create_tween().set_parallel(true)
	tween.tween_method(func(p: Vector2): camera.global_position = p.round(), cam_start, cam_end, SCROLL_TIME)
	tween.tween_property(player, "global_position", landing, SCROLL_TIME)
	await tween.finished

	player.set_process(true)
	scrolling = false
