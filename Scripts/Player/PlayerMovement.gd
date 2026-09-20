class_name PlayerEntity
extends CharacterBody2D

#OH THANK GOD
@export var speed = 50
var input_dir = Vector2(0,0)
var PreviousDirection = ""

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
	
func _on_spawn(spawn_position: Vector2, direction: String):
	global_position = spawn_position
	$AnimatedSprite2D.play("Walk " + direction)
	

func _process(delta: float) -> void:
	move_and_slide();
	player_movement();
	player_rotate();

func player_movement():
	input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed

func player_rotate():
	if input_dir == Vector2(0, 1):
		$AnimatedSprite2D.play("Walk Down")
		PreviousDirection = "Down"
	elif input_dir == Vector2(0, -1):
		$AnimatedSprite2D.play("Walk Up")
		PreviousDirection = "Up"
	elif input_dir.x < 0:
		$AnimatedSprite2D.play("Walk Left");
		PreviousDirection = "Left";
	elif input_dir.x > 0:
		$AnimatedSprite2D.play("Walk Right");
		PreviousDirection = "Right"
	if input_dir == Vector2(0,0):
		if PreviousDirection == "Up":
			$AnimatedSprite2D.play("Idle Up");
		elif PreviousDirection == "Left":
			$AnimatedSprite2D.play("Idle Left");
		elif PreviousDirection == "Right":
			$AnimatedSprite2D.play("Idle Right");
		else:
			$AnimatedSprite2D.play("Idle");
