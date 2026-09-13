extends Resource
class_name PotionResource

#const _2 = preload("uid://cqc06pjj7bwiw")
#const _3 = preload("uid://cnq3syo14otji")
#const _4 = preload("uid://c1si2wxxowxlq")
#const _5 = preload("uid://tcdovan5x8pv")
#const _6 = preload("uid://cwaekq8ueepk4")
#const _7 = preload("uid://2ejdeqhj2jf5")
#const _8 = preload("uid://jjrevmmym0qe")
#const _9 = preload("uid://coxgvlw8left2")
#const _10 = preload("uid://d1uudntp6xwm3")
#const _11 = preload("uid://maa4p1361m2d")
#const _12 = preload("uid://d35qefrh5c0kv")
#const _13 = preload("uid://bw7mf3h4cwa71")
#const _14 = preload("uid://bau5mfjqfagm7")
#const _15 = preload("uid://d0kf4jtqwa3nr")
#const _16 = preload("uid://d04vpv8xhh2xj")
#const _17 = preload("uid://cr3cnndu7eeqc")
#const _18 = preload("uid://ooiwfdsf01ic")
#const _19 = preload("uid://bg044w2iejp6n")
#const _20 = preload("uid://dfeg2nxt30xei")
#const _21 = preload("uid://destnyue6uyqg")
#const _22 = preload("uid://nvan4d4wcl2a")
#const _23 = preload("uid://cdonnrqjdtr2v")
#const _24 = preload("uid://chmf5n31q8oqb")
#const _25 = preload("uid://o6upml5wyxgg")
#const POTION_2__1_ = preload("uid://dvyry1n14vn3s")
#const POTION_2__2_ = preload("uid://dcbubw01iel1x")
#const POTION_2__3_ = preload("uid://da5kds2c2ylft")
#const POTION_2__4_ = preload("uid://chbk07a6vd0fn")
#const POTION_2__5_ = preload("uid://8oam32xhfyph")
#const POTION_2__6_ = preload("uid://dpuhlw0xrx0vw")
#const POTION_2__7_ = preload("uid://c1gpc6hruukfj")
#const POTION_2__8_ = preload("uid://bqrrccnwb4ub8")
#const POTION_2__9_ = preload("uid://2k6a0p5s7lfu")
#const POTION_2__10_ = preload("uid://dfabqww6gqrpe")
#const POTION_2__11_ = preload("uid://1m851v2bpyho")
#const POTION_2__12_ = preload("uid://bipcqlaswnlvu")
#const POTION_2__13_ = preload("uid://xbpdapavhyta")
#const POTION_2__14_ = preload("uid://f6p7sx33ty42")
#const POTION_2__15_ = preload("uid://dabo2euty5f0u")
#const POTION_2__16_ = preload("uid://cyn1a2suj6a4k")
#const POTION_2__17_ = preload("uid://bwaw25e8qsvro")
#const POTION_2__18_ = preload("uid://djemc8wm0krph")
#const POTION_2__19_ = preload("uid://wk3lwi0t5chd")
#const POTION_2__20_ = preload("uid://cx31fnmm67kpv")
#const POTION_2__21_ = preload("uid://8a3nam1dyjk7")
#const POTION_2__22_ = preload("uid://mp5clhhl6wpy")
#const POTION_2__23_ = preload("uid://cda14cyq61bfi")
#const POTION_2__24_ = preload("uid://bv4e2bul4grou")
#const POTION_2__25_ = preload("uid://cxwfnwj2ida0f")
#const POTION_2__26_ = preload("uid://dxwhwlot3nq8j")
#const POTION_2__27_ = preload("uid://c1f354d83gplm")
#const POTION_2__28_ = preload("uid://2w27wqcb830a")
#const POTION_2__29_ = preload("uid://4dnh784m4fy5")
#const POTION_2__30_ = preload("uid://cdcnd0cyowd18")
#const POTION_2__31_ = preload("uid://87f7s0hxv2a8")
#const POTION_2__32_ = preload("uid://ryfatc10iwew")
#const POTION_2__33_ = preload("uid://bo5bjgxqngxiv")
#const POTION_2__34_ = preload("uid://bm821dbjebbf3")
#const POTION_2__35_ = preload("uid://cfiwasyscyecs")


@export var rarity: Rarity
@export var ingredient_hierarchy: int
@export var name: String
@export var description: String

@export var sprite: Texture2D

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	VERY_RARE,
	LEGENDARY
}

#rarity directly related to price not production cost
##common
##uncommon
##rare
##very rare
##Legenndary
#ingredient hierarchy count -- directly related to production cost
##1-5 (would require 2^5 -1 = 31 total items) 5 is high production cost 1 is low production cost (0 is ingredient)
#name -- string
#description 
## file location of a string instead
