/*
 * Re-define the menu item class because it is not guaranteed that it exists in every mod.
 * Note, that the original class/prototype are not overwritten but unique symbol names are used.
 */

class GFA_CCamSys {
    var float bestRange;
    var float minRange;
    var float maxRange;
    var float bestElevation;
    var float minElevation;
    var float maxElevation;
    var float bestAzimuth;
    var float minAzimuth;
    var float maxAzimuth;
    var float bestRotZ;
    var float minRotZ;
    var float maxRotZ;
    var float rotOffsetX;
    var float rotOffsetY;
    var float rotOffsetZ;
    var float targetOffsetX;
    var float targetOffsetY;
    var float targetOffsetZ;
    var float veloTrans;
    var float veloRot;
    var int translate;
    var int rotate;
    var int collision;
};
