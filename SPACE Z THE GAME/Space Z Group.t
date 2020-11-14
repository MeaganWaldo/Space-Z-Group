#charset "us-ascii"

/*
 *   TADS 3 Copyright (c) 1999, 2002 by Michael J. Roberts.  Permission is
 *   granted to anyone to copy and use this file for any purpose.
 */ 

/* 
 *   Include the main header for the standard TADS 3 adventure library.
 *   Note that this does NOT include the entire source code for the
 *   library; this merely includes some definitions for our use here.  The
 *   main library must be "linked" into the finished program by including
 *   the file "adv3.tl" in the list of modules specified when compiling.
 *   In TADS Workbench, simply include adv3.tl in the "Source Files"
 *   section of the project.
 *   
 *   Also include the US English definitions, since this game is written
 *   in English.  
 */
#include <adv3.h>
#include <en_us.h>

/*
 *   Our game credits and version information.  This object isn't required
 *   by the system, but our GameInfo initialization above needs this for
 *   some of its information.
 */
versionInfo: GameID
    IFID = '349b9587-c79f-4bd2-af42-e04570ad5f8b'
    name = 'SPACE Z: THE GAME'
    byline = 'by Johnathon Garcia, Meagan Waldo, Kashka Calvin, Erik Alvarez,  Nasley Chumacero-Martin'
    htmlByline = 'by <a href="mailto:john48@nmsu.edu, mwaldo@nmsu.edu, kashka@nmsu.edu, nchumace@nmsu.edu">
                  Johnathon Garcia, Meagan Waldo, Kashka Calvin, Erik Alvarez,  Nasley Chumacero-Martin</a>'
    version = '1'
    authorEmail = 'Johnathon Garcia, Meagan Waldo, Kashka Calvin, Erik Alvarez,  Nasley Chumacero-Martin 
        <john48@nmsu.edu, mwaldo@nmsu.edu, kashka@nmsu.edu, nchumace@nmsu.edu>'
    desc = 'SPACE Z: THE GAME'
    htmlDesc = 'SPACE Z: THE GAME'
;

/*
 *   The "gameMain" object lets us set the initial player character and
 *   control the game's startup procedure.  Every game must define this
 *   object.  For convenience, we inherit from the library's GameMainDef
 *   class, which defines suitable defaults for most of this object's
 *   required methods and properties.  
 */
gameMain: GameMainDef
    /* the initial player character is 'me' */
    initialPlayerChar = me
;


/*
 * Door keys are defined outside of the rooms and then placed inside with @.
 */
SecurityKey : Key 'Security key/card' 'Security key card' @CommonRoom;
MedKey : Key 'Medbay key/med bay key/card' 'Med Bay key card' @CommonRoom;
ShuttleKey : Key 'Shuttlebay key/shuttle bay key/card' 'Shuttle Bay key card' @CommonRoom;
BathKey : Key 'bathroom key/card' 'Bathroom key card' @CommonRoom;



/*
 *   Define the player character.  The name of this object is not
 *   important, but it MUST match the name we use to initialize
 *   gameMain.initialPlayerChar above.
 *   
 *   Note that we aren't required to define any vocabulary or description
 *   for this object, because the class Actor, defined in the library,
 *   automatically provides the appropriate definitions for an Actor when
 *   the Actor is serving as the player character.  Note also that we don't
 *   have to do anything special in this object definition to make the
 *   Actor the player character; any Actor can serve as the player
 *   character, and we'll establish this one as the PC in main(), below.  
 */
+ me: Actor
    location = SleepingQuarters
;



/*
 *  This is our component that controls HP.
 */
+MyHP: Component 'my hp/health/life/hitpoints'
    desc="Current Health: <<CurHP>>/<<MaxHP>>"  // Command that shows current health out of max amount.
    MaxHP = 5  // Max amount of HP player can have.
    CurHP = 3  // Current amount of HP player has.
    healAmount = 1 // Amount of HP for the player that is healed each healing.
    FAidUses=3 // uses of med kit
    
    // This method controls health regen.
    regenHP() { 
        // If the current health is less then the max health increase health. 
        if(CurHP < MaxHP) {
            CurHP += healAmount;
            FAidUses--; // decrement uses of first aid kit
            
            "You feel a bit better! ";
            "Current Health: <<CurHP>>/<<MaxHP>> ";
            "First aid uses left: <<FAidUses>> ";
            
            if(FAidUses == 0) { // check to see if we ran out of uses.
                "You have ran out of first aid kit uses! ";
                 FirstAidKit.location = nil; // removes the firstaid kit after use.
            FirstAidKit.isListedInInventory = nil; // removes the firstaid kit after use.
                FAidUses=3;
                
            }// end nested if for uses          
        } // end of if
        else {
            CurHP=MaxHP;
            
            "You are already fully healed. ";        
            "Current Health: <<CurHP>>/<<MaxHP>> ";
        } // end of else        
    }// end regenHP
    
    // This method controls health damage.
    damageHP () {
        CurHP --;
       
        "Ouch! That hurt.";
       
        // If the current health is 0 the player is dead.
        if(CurHP == 0){
            "You're out of HP!";
            finishGameMsg(ftDeath, []);
        } // end of if
       
        "Current Health: <<CurHP>>/<<MaxHP>>"; 
    } // end of damageHP  
;



/*
 *  This defines an action that the player can use in specific conditions.
 */
DefineIAction(heal) execAction() {
        // If the player has the firstaid kit then they may use it to regen HP.    
        if(FirstAidKit.location == me){
            MyHP.regenHP();
             } // end of if
    else
        "You need a First aid kit to heal. ";
    } // end of DefineIAction for heal
;



/*
 *  This gives verb rules to an action.
 */
VerbRule(regen)
    'heal' | 'healing' : healAction
    verbPhrase = 'heal/healing'
;



/*
 *  This defines an action that the player can use in specific conditions.
 */
DefineIAction(damage) execAction() {  
    // If the player has the cactus then they may use it to damage their HP.    
    if(cactus.location == me){   
        MyHP.damageHP ();  
    } // end of if 
}// end of DefineIAction for damage
;




/*
 *  This gives verb rules to an action.
 */
VerbRule (damage)
    'damage' | 'hploss' : damageAction
    verbPhrase = 'damage/hploss'
;