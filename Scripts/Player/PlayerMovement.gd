class_name PlayerEntity
extends CharacterBody2D

#OH THANK GOD 
#-- if you can read this message you're cool

#sprite for the potion on player's head
@onready var sprite_2d: Sprite2D = $Sprite2D
#node to add potion objects to
@onready var potion_pickups: Node = $"../PotionPickups"
const POTION_1 = preload("uid://cpjnwjxvilulc")

@export var speed = 50

var input_dir = Vector2(0,0)
var PreviousDirection = ""

#potion stuff
var inventory_potion : PotionResource = null
var standing_on_potion : bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
	SignalBus.item_pickup.connect(_on_potion_pickup)
	SignalBus.item_dropped.connect(_on_potion_dropped)
	sprite_2d.texture = null
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
	velocity = input_dir * 50

func player_rotate():
	if input_dir == Vector2(0, 1):
		if inventory_potion:
			$AnimatedSprite2D.play("Carry Down")
		else:
			$AnimatedSprite2D.play("Walk Down")
		PreviousDirection = "Down"
	elif input_dir == Vector2(0, -1):
		if inventory_potion:
			$AnimatedSprite2D.play("Carry Up")
		else:
			$AnimatedSprite2D.play("Walk Up")
		PreviousDirection = "Up"
	elif input_dir.x < 0:
		if inventory_potion:
			$AnimatedSprite2D.play("Carry Left")
		else:
			$AnimatedSprite2D.play("Walk Left");
		PreviousDirection = "Left";
	elif input_dir.x > 0:
		if inventory_potion:
			$AnimatedSprite2D.play("Carry Right")
		else:
			$AnimatedSprite2D.play("Walk Right");
		PreviousDirection = "Right"
	if input_dir == Vector2(0,0):
		if PreviousDirection == "Up":
			if inventory_potion:
				$AnimatedSprite2D.play("Carry Up Idle")
			else:
				$AnimatedSprite2D.play("Idle Up");
		elif PreviousDirection == "Left":
			if inventory_potion:
				$AnimatedSprite2D.play("Carry Left Idle")
			else:
				$AnimatedSprite2D.play("Idle Left");
		elif PreviousDirection == "Right":
			if inventory_potion:
				$AnimatedSprite2D.play("Carry Right Idle")
			else:
				$AnimatedSprite2D.play("Idle Right");
		else:
			if inventory_potion:
				$AnimatedSprite2D.play("Carry Down Idle")
			else:
				$AnimatedSprite2D.play("Idle");

func _unhandled_input(event : InputEvent) -> void:
	#print("button pushed")
	if event.is_action_pressed("GB_SELECT"):
		#time is meant to make it wait just long enough so that if something else is goign to get pickedup by the player it will first and then check
		await get_tree().create_timer(.2).timeout
		#if inventory_potion:
			#var new_potion = POTION_1.instantiate()
			#new_potion.create_instantiated_potion(global_position, inventory_potion)

func _on_potion_pickup(item : PotionResource) -> void:
	print("potion picked up")
	standing_on_potion = true
	sprite_2d.texture = item.sprite
	inventory_potion = item

func _on_potion_dropped(item : PotionResource) -> void:
	sprite_2d.texture = null
	inventory_potion = null
