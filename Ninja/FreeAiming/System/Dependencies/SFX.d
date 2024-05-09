/*
 * Re-define the menu item class because it is not guaranteed that it exists in every mod.
 * Note, that the original class/prototype are not overwritten but unique symbol names are used.
 */

class GFA_C_SFX {
    var string file;
    var int pitchoff;
    var int pitchvar;
    var int vol;
    var int loop;
    var int loopstartoffset;
    var int loopendoffset;
    var float reverblevel;
    var string pfxname;
};
