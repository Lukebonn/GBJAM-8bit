extends Node

static var adventurer = Adventurer.new()
static var druid = Druid.new()
static var evil = Evil.new()
static var goblin = Goblin.new()
static var newt = Newt.new()
static var romantic = Romantic.new()
static var ruler = Ruler.new()
static var thief = Thief.new()

static var a = 0;
static var b = 0;
static var c = 0;
static var d = 0;
static var e = 0;
static var f = 0;
static var g = 0;
static var h = 0;

static var QUESTS: Dictionary = {
	1: adventurer.QUESTS_DATA[a],
	2: druid.QUESTS_DATA[b],
	3: evil.QUESTS_DATA[c],
	4: goblin.QUESTS_DATA[d],
	5: newt.QUESTS_DATA[e],
	6: romantic.QUESTS_DATA[f],
	7: ruler.QUESTS_DATA[g],
	8: thief.QUESTS_DATA[h],
}

func cycle_quests():
	pass
	
func quest_complete():
	pass
