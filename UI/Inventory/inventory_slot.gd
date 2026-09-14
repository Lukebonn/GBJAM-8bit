extends Panel

var item1 = preload("uid://cpjnwjxvilulc")
var item2 = preload("uid://4nj4o4mb1tm2")
var item3 = preload("uid://bohvbn2p0xrb2")
var item = null
var rand = randi_range(1, 3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if rand % 4 == 0:
		item = item1.instantiate()
	elif rand % 3 == 1:
		item = item2.instantiate()
	elif rand % 3 == 2:
		item = item3.instantiate()
	
	add_child(item)
	item.set_position_in_slot(size)
