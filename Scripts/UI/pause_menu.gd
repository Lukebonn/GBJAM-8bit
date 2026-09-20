extends Control

@export var menu_tabs : Array[MenuTab]
@export var screens : Array[Control]

var current_tab : int = 0

signal switch_tab(tab : int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#visible = false
	set_cur_tab(current_tab)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("GB_SELECT"):
		if current_tab == 2:
			set_cur_tab(0) 
		else:
			set_cur_tab(current_tab+1) 

func set_cur_tab(tab : int) -> void:
	current_tab = tab
	
	var idx : int = 0
	for t in menu_tabs:
		if idx == tab:
			t.is_active_tab = true
			screens[idx].visible = true
		else:
			t.is_active_tab = false
			screens[idx].visible = false
		
		idx += 1
