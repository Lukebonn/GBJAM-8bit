class_name Interactable
extends Node

@export var node : Area2D
@export var notif : Label

var can_interact : bool = false

signal interact

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	node.body_entered.connect(_on_player_enter)
	node.body_exited.connect(_on_player_exit)

func _process(delta: float) -> void:
	notif.visible = can_interact

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("SC_UP") and can_interact:
		emit_signal("interact")

func _on_player_enter(body : Node2D) -> void:
	print("can interact")
	print(node)
	if body is Player:
		player = body
		can_interact = true

func _on_player_exit(body : Node2D) -> void:
	print("cant interact")
	if body is Player:
		player = null
		can_interact = false
