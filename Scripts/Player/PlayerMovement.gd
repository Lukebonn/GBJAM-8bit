class_name PlayerEntity
extends CharacterBody2D

#OH THANK GOD 
#-- if you can read this message you're cool

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var speed = 50
var inventory_potion : PotionResource = null
var input_dir = Vector2(0,0)
var PreviousDirection = ""

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
	SignalBus.item_pickup.connect(_on_potion_pickup)
	SignalBus.item_dropped.connect(_on_potion_dropped)
	sprite_2d.texture = null

func _process(delta: float) -> void:
	move_and_slide();
	player_movement();
	player_rotate();

func player_movement():
	input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * 50

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

func _on_potion_pickup(item : PotionResource) -> void:
	sprite_2d.texture = item.sprite
	inventory_potion = item

func _on_potion_dropped(item : PotionResource) -> void:
	sprite_2d.texture = null
