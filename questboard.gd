extends Node

enum {
	NUM,
	DATA
}

#I instantiated a new instance of each class to be able to access them here

static var adventurer = Adventurer.new()
static var druid = Druid.new()
static var evil = Evil.new()
static var goblin = Goblin.new()
static var newt = Newt.new()
static var romantic = Romantic.new()
static var ruler = Ruler.new()
static var thief = Thief.new()

#that ints here are to move to the next quest after completing one

static var a = 0;
static var b = 0;
static var c = 0;
static var d = 0;
static var e = 0;
static var f = 0;
static var g = 0;
static var h = 0;

#This will access everything in each questline

static var QUESTS: Dictionary[String, Dictionary] = {
	"Adventurer": {
		NUM: a,
		DATA: adventurer.QUESTS_DATA[a],
	},
	"Druid": {
		NUM: b,
		DATA: druid.QUESTS_DATA[b],
	},
	"Evil": {
		NUM: c,
		DATA: evil.QUESTS_DATA[c],
	},
	"Goblin": {
		NUM: d,
		DATA: goblin.QUESTS_DATA[d],
	},
	"Newt": {
		NUM: e,
		DATA: newt.QUESTS_DATA[e],
	},
	"Romantic": {
		NUM: f,
		DATA: romantic.QUESTS_DATA[f],
	},
	"Ruler": {
		NUM: g,
		DATA: ruler.QUESTS_DATA[g],
	},
	"Thief": {
		NUM: h,
		DATA: thief.QUESTS_DATA[h],
	},
}

func cycle_quests():
	# this will get a random quest
	return QUESTS.values().pick_random()
	
	
func quest_complete(quest_num: int):
	pass
