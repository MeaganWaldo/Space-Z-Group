#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

  
/*
 * This file uses customBanner.t to display graphics in the game
 * banner. It uses the player's current hit points to decide which
 * hit point graphic should be used. The default is hp5.png, but this
 * graphic may not appear on all interpreters.
 */
hitpointsBanner: CustomBannerWindow {
    
    // Checks if the system can display png graphics and if so, displays the default  5 hitpoints graphic.
    canDisplay = (systemInfo(SysInfoPng))
    
    // The one property that must be defined on each instance of a CustomBannerWindowis bannerArgs, which takes the form: bannerArgs = [parent, where, other, windowType, align, size, sizeUnits, styleFlags].
    bannerArgs = [nil, BannerFirst, statuslineBanner, BannerTypeText, 
        BannerAlignTop, 4, BannerSizeAbsolute, BannerStyleBorder]
;
    

/*
 * This function is called to determine the image that is displayed for the hit points banner.
 */
showHitpoints(CurHP)  {
    clearWindow();

    // Calling updateContents() changes what the banner displays. It contains two arguments but the second argument is optional.
    if (CurHP == 5)  {
        hitpointsBanner.updateContents('<img src="hpgraphics/hp5.png">');
    } // end of if            
    else if (CurHP ==4)  {
        hitpointsBanner.updateContents('<img src="hpgraphics/hp4.png">');
    } // end of else if
     else if (CurHP ==3)  {
        hitpointsBanner.updateContents('<img src="hpgraphics/hp3.png">');
    } // end of else if  
     else if (CurHP ==2)  {
        hitpointsBanner.updateContents('<img src="hpgraphics/hp2.png">');
    } // end of else if
     else if (CurHP ==1)  {
        hitpointsBanner.updateContents('<img src="hpgraphics/hp1.png">');
    } // end of else if
} // end of function showHitpoints 
} // end of hitpointsBanner