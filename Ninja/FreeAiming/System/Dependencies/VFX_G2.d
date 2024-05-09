/*
 * Re-define the menu item class because it is not guaranteed that it exists in every mod.
 * Note, that the original class/prototype are not overwritten but unique symbol names are used.
 */

class GFA_CFx_Base {
    var string visname_s;
    var string vissize_s;
    var float visalpha;
    var string visalphablendfunc_s;
    var float vistexanifps;
    var int vistexaniislooping;
    var string emtrjmode_s;
    var string emtrjoriginnode;
    var string emtrjtargetnode;
    var float emtrjtargetrange;
    var float emtrjtargetazi;
    var float emtrjtargetelev;
    var int emtrjnumkeys;
    var int emtrjnumkeysvar;
    var float emtrjangleelevvar;
    var float emtrjangleheadvar;
    var float emtrjkeydistvar;
    var string emtrjloopmode_s;
    var string emtrjeasefunc_s;
    var float emtrjeasevel;
    var float emtrjdynupdatedelay;
    var int emtrjdynupdatetargetonly;
    var string emfxcreate_s;
    var string emfxinvestorigin_s;
    var string emfxinvesttarget_s;
    var float emfxtriggerdelay;
    var int emfxcreatedowntrj;
    var string emactioncolldyn_s;
    var string emactioncollstat_s;
    var string emfxcollstat_s;
    var string emfxcolldyn_s;
    var string emfxcolldynperc_s;
    var string emfxcollstatalign_s;
    var string emfxcolldynalign_s;
    var float emfxlifespan;
    var int emcheckcollision;
    var int emadjustshptoorigin;
    var float eminvestnextkeyduration;
    var float emflygravity;
    var string emselfrotvel_s;
    var string userstring[5];
    var string lightpresetname;
    var string sfxid;
    var int sfxisambient;
    var int sendassessmagic;
    var float secsperdamage;
};

class GFA_C_ParticleFXEmitKey {
    var string visname_s;
    var float vissizescale;
    var float scaleduration;
    var float pfx_ppsvalue;
    var int pfx_ppsissmoothchg;
    var int pfx_ppsisloopingchg;
    var float pfx_sctime;
    var string pfx_flygravity_s;
    var string pfx_shpdim_s;
    var int pfx_shpisvolumechg;
    var float pfx_shpscalefps;
    var float pfx_shpdistribwalkspeed;
    var string pfx_shpoffsetvec_s;
    var string pfx_shpdistribtype_s;
    var string pfx_dirmode_s;
    var string pfx_dirfor_s;
    var string pfx_dirmodetargetfor_s;
    var string pfx_dirmodetargetpos_s;
    var float pfx_velavg;
    var float pfx_lsppartavg;
    var float pfx_visalphastart;
    var string lightpresetname;
    var float lightrange;
    var string sfxid;
    var int sfxisambient;
    var string emcreatefxid;
    var float emflygravity;
    var string emselfrotvel_s;
    var string emtrjmode_s;
    var float emtrjeasevel;
    var int emcheckcollision;
    var float emfxlifespan;
};
