extends Quests

static var QUESTS_DATA: Dictionary[String, Dictionary] = {
	"The Druid 1": {
		DESCRIPTION: "Dear Alchemist, I am looking for your help in acquiring an earth potion. 
		The plants around me have been hurting, and I believe this will be the best way to heal them.",
		POTION: "Earth",
		COUNT: 1
	},
	"The Druid 2": {
		DESCRIPTION: "Thank you for that last potion, it worked temporarily. 
		However, this war between the ruler and the evil has been ruining the nearby forest. 
		I need 4 more earth potions to help the forest.",
		POTION: "Earth",
		COUNT: 4
	},
	"The Druid 3": {
		DESCRIPTION: "My efforts have been fruitless thus far. I have not been able to help patch 
		the forest's wounds. Now, some of the animals have been caught in the crossfire of this war. 
		Get me 4 healing potions as quickly as you can.",
		POTION: "Healing",
		COUNT: 4
	},
	"The Druid 4": {
		DESCRIPTION: "The healing potions were effective in helping the animals. 
		However, the armies keep fighting inside of the forest. I need to drive them away as best as 
		I can. Give me an invisibility potion so that I may set up traps.",
		POTION: "Invisibility",
		COUNT: 4
	},
	"The Druid 5": {
		DESCRIPTION: "That worked, I have dwindled down the armies. It appears, however, 
		that they are after my head. Thank you for all the help so far, alchemist. This may be my 
		last battle, but I will not go down without taking them with me. Please, send me 4 death potions.",
		POTION: "Death",
		COUNT: 4
	},
}
