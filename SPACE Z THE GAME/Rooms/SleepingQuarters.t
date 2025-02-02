#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>


/*
 * This file is for the Sleeping Quarters and any objects that
 * may be contained here. This is also the starting location
 * for the player. NOTE: DO NOT change the room name without
 * also changing the initial location of the character player defined
 * in the "me" object in the main game file.
 */


/*
 * ROOM: Sleeping Quarters
 * NPC's: None
 * Carry Objects: cactus
 */
SleepingQuarters: Room 'Sleeping Quarters'
    "The room is a tall elongated atrium with soothing fluorescent lighting. Everywhere
    you look along the walls, there are sleeping pods neatly 
    stacked like bunk beds and small chests anchored to the wall for each occupant to store
    their personal belongings. There isn't a person in sight. To the east are the bathrooms,
    and to the west is the Common Room. "
    east = Commondoor
    west = Bathdoor   
;


/*
 * Door that leads into the Bathroom.
 */
+ Bathdoor: LockableWithKey, Door 'bath bathroom door' 'Bathroom Door'
    "A metal airlock door that leads to the bathroom. "
    keyList = [BathKey] 
    pic = artBanner.showArt('metaldoor')
;


/*
 * Door that leads into the CommonRoom.
 */
+ Commondoor: Door 'common commonroom door' 'Common Room Door'
    "Heavy metal airlock door that leads to the Common Room. "
    pic = artBanner.showArt('metaldoor')
;


/*
 *  This object is a green cactus.
 */
cactus : Thing  
  name = 'Cactus'  // Name of the object.
  noun = 'Cactus' // Nouns that the object may be known as.
  desc = "The potted plant is small green cactus. The needles look sharp."  // Description of the object.
  adjective = 'green' 'sharp'  // Attributes that the object has.
  location = SleepingQuarters  // Location of the object.
  pic = artBanner.showArt('cactus') // The art that is displayed when the item is looked at.
;       