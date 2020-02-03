# Hail-to-the-King
IOS RPG

These files are meant to be run with XCode, a Mac coding application for IOS development. Also, the only currently supported device type is the iPad Pro(11-inch) so if you want to play this on the XCode simulator, set the device to iPad Pro(11-inch) on landscape mode.

When downloading the code to test or run it, download the Battleheart Legacy 2 folder and Hail to the King.xcodeproj - the other files are extraneous.

This game allows the player to control four different heroes as they battle enemies in real time. The heroes are meant to be used synergystically so as to best survive each level's onslaught of enemies. The heroes are on a quest to vanquish a mad king who brough the realm to ruin.



--- Background Story for Hail to the King --

The land of Aarondel was once a peaceful land centered on commerce, trading with the forest elves to the west and the Heftypants dwarves and Wankendriver Gnomes in the northern mountains. Exiled from the Underdark, a mind-flayer took refuge within the city. As it grew in strength through harvesting humans, king Ethric's wife, Elthamira, disappeared. Ethric employed all of the kingdom's resources in the search. Upon discovering the beast, he sent in his royal gaurd and, after a desperate battle, the blight was killed. Before any form of joy or triumph in conquering this evil, Ethric discovered his wife's corpse within the beast's lair. In his despair, he resolved to bring her back and reverse the tragedy by any means necessary. Ethric began researching the forbidden art of necromancy alone in his throne room. For months he read and re-read every tome and scroll in the kingdom pertaining to this dark magic. Finally, he began the ritual to bring back the dead. King Ethric succeeded in returning Elthamira to the land of the living, however, he paid a grave price. Ethric forever lost his sanity along with Elthamira. Together they scourged the land they once loved, bringing everything they had built to ruin. Refugees from Aarondel called upon the bravest and strongest heroes to save them. This is where the story of Hail to the King begins...

--------------------------------------------------------------------------------------------
12/13 changelog - added a red background to image views to check for accuracy, fixed bugs with melee attack animations, added in melee enemy code, added knockback after being attacked, and changed the Level.enemyLoadTable into a 2D array of Character objects to accurately determine when enemy waves should enter and when combat should close.
--------------------------------------------------------------------------------------------
12/17 changelog - added in character unique, custom abilities accessible through buttons. Concise code for calling these unique abilites was done through a "creative solution" entailing conversion between swift code to objc and then back to swift in order to call methods with a string.
--------------------------------------------------------------------------------------------
12/31 changelog - implimented base talent selection screen with buttons and draggable item selections
--------------------------------------------------------------------------------------------
1/3 changelog - big updates to the item screen with dragging and shifting item placements within the inventory and equipping items - also updated talent UI and shortened code in many areas
--------------------------------------------------------------------------------------------
1/4 changelog - added the Heroes Screen which allows the player to switch around which heroes are active, also minor UI updates and bug fixes.
--------------------------------------------------------------------------------------------
1/15 - Temporary changes -- unfinished edits to how user interaction with gameplay happens - with this, combat will not function properly at the moment and will likely cause crashes.
--------------------------------------------------------------------------------------------
1/29 changelog - fixed up combat with the new user interactions with characters being drags and taps rather than the more complicated old tap only system. Fixed up the map page for selecting levels. Added .xcarchive file for running on an actual iOS device (provided you circumvent the apple iOS blocks since I am not a registered dev) and deleted extraneous files.
--------------------------------------------------------------------------------------------
