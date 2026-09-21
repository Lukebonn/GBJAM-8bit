class_name Adventurer
extends Quests

static var QUESTS_DATA: Dictionary[String, Dictionary] = {
	"The Adventurer 1": {
		DESCRIPTION: "Hey, I’m a new adventurer and I am looking to slay some goblins. 
		In order to do that however, I need a potion to keep me topped up in battle. 
		Could you send me a lesser health potion?",
		POTION: "Lesser Healing",
		COUNT: 1
	},
	"The Adventurer 2": {
		DESCRIPTION: "Thanks for the last potion! Because of you, I got to join a guild. 
		I have met so many new people already! Some of us want to go into a dungeon to help fight 
		The Evil that surrounds us. Could you send us a healing potion? Thanks in advance.",
		POTION: "Healing",
		COUNT: 1
	},
	"The Adventurer 3": {
		DESCRIPTION: "Thank you for the potions! We were able to clear that dungeon thanks to you. 
		Now my guildmates want to go rescue a town that’s been overrun by The Evil. They think that 
		it’s going to be easy with the lesser healing we have left over, but I’m not so sure. 
		Can you send a potion of strength, just to be safe?",
		POTION: "Strength",
		COUNT: 1
	},
	"The Adventurer 4": {
		DESCRIPTION: "I am greatly indebted to you! We were overrun by monsters, 
		but that potion helped save our lives. However, thanks to our meddling, we believe we’re 
		being targeted by The Evil. Could you send us a potion of greater healing? That should 
		help us win this fight!",
		POTION: "Greater Healing",
		COUNT: 1
	},
	"The Adventurer 5": {
		DESCRIPTION: "The guild was destroyed by The Evil. No one survived, 
		not even my party members. Now I haven’t just lost my family to it, but my closest friends 
		too. I don’t care about myself anymore, I’m taking The Evil straight on! Could you send me a 
		potion of invincibility? I believe this will be my last fight so let me just say, thank you 
		for your help and take care of yourself.",
		POTION: "Invincibility",
		COUNT: 1
	},
}
