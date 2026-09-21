class_name Goblin
extends Quests

static var QUESTS_DATA: Dictionary[String, Dictionary] = {
	"The Goblin 1": {
		DESCRIPTION: "Hey there Alchemist, I'm tryin’ to steal some gold from a big dragon but I 
		ain’t a fighter. Could you cook me up a poison potion so that I can get the dragon away from 
		the gold so I can steal it for myself?",
		POTION: "Poison",
		COUNT: 1,
		GOLD_REWARD: 10
	},
	"The Goblin 2": {
		DESCRIPTION: "Thanks for the poison you made, it tastes great. For a reason I'm not at 
		liberty to tell you I now am in urgent need of a poison antidote potion. Once I get this done 
		with, I can get back to stealing me some gold.",
		POTION: "Antidote",
		COUNT: 1,
		GOLD_REWARD: 20
	},
	"The Goblin 3": {
		DESCRIPTION: "Thanks for the antidote! However, I still need something to steal the gold. 
		I know, why don’t you make me an invisibility potion. Then I’ll be able to steal as much gold 
		as I want!",
		POTION: "Invisibility",
		COUNT: 1,
		GOLD_REWARD: 30
	},
	"The Goblin 4": {
		DESCRIPTION: "That idea worked, but the dragon still found me and scared me away! To think 
		that being invisible doesn’t mean you can’t be heard. Either way, my new plan is a speed potion! 
		It can’t catch me if I run circles around it.",
		POTION: "Speed",
		COUNT: 1,
		GOLD_REWARD: 40
	},
	"The Goblin 5": {
		DESCRIPTION: "The last potion didn’t help. I was able to run in, but the dragon just spewed 
		a bunch of fire around the treasure! That cheat! I know exactly how to counter it. For my 
		last potion, alchemist, make me a fire resistance potion! That way, I can’t get hurt by fire. 
		My plan is foolproof!",
		POTION: "Fire Immunity",
		COUNT: 1,
		GOLD_REWARD: 50
	},
}
