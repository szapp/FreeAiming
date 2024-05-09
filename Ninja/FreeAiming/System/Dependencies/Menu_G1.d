/*
 * Re-define the menu item class because it is not guaranteed that it exists in every mod.
 * Note, that the original class/prototype are not overwritten but unique symbol names are used.
 */

class GFA_C_Menu_Item /* C_Menu_Item */ {
    var string fontName;
    var string text[10];
    var string backPic;
    var string alphaMode;
    var int alpha;
    var int type;
    var int onSelAction[5];
    var string onSelAction_S[5];
    var string onChgSetOption;
    var string onChgSetOptionSection;
    var func onEventAction[10];
    var int posx;
    var int posy;
    var int dimx;
    var int dimy;
    var float sizeStartScale;
    var int flags;
    var float openDelayTime;
    var float openDuration;
    var float userFloat[4];
    var string userString[4];
    var int frameSizeX;
    var int frameSizeY;
};
