/*
 * Re-write common constants that might be missing in mods
 * ONLY DEFINE CONSTANTS THAT HAVE DEFINITELY ALWAYS THE SAME VALUES!
 */
const int GFA_IDX_EXE   = 0; // Game version index

const int ATR_STRENGTH  = 4;
const int ATR_DEXTERITY = 5;

const int FMODE_NONE    = 0;
const int FMODE_FIST    = 1;
const int FMODE_MELEE   = 2;

const int PROT_POINT    = 6;

const int ITEM_KAT_MUN  = 1 << 3;
const int ITEM_BOW      = 1 << 19;
const int ITEM_CROSSBOW = 1 << 20;

const int NPC_RUN             = 0;
const int NPC_SNEAK           = 2;

const int TARGET_COLLECT_NONE                  = 0;
const int TARGET_COLLECT_CASTER                = 1;
const int TARGET_COLLECT_FOCUS                 = 2;
const int TARGET_COLLECT_ALL                   = 3;
const int TARGET_COLLECT_FOCUS_FALLBACK_NONE   = 4;
const int TARGET_COLLECT_FOCUS_FALLBACK_CASTER = 5;
const int TARGET_COLLECT_ALL_FALLBACK_NONE     = 6;
const int TARGET_COLLECT_ALL_FALLBACK_CASTER   = 7;

const int TARGET_TYPE_ALL    = 1;
const int TARGET_TYPE_ITEMS  = 2;
const int TARGET_TYPE_NPCS   = 4;
const int TARGET_TYPE_ORCS   = 8;
const int TARGET_TYPE_HUMANS = 16;
const int TARGET_TYPE_UNDEAD = 32;

const int MAT_WOOD    = 0;
const int MAT_STONE   = 1;
const int MAT_METAL   = 2;
const int MAT_LEATHER = 3;
const int MAT_CLAY    = 4;
const int MAT_GLAS    = 5;

const int PERC_OBSERVEINTRUDER  = 12;
const int PERC_ASSESSQUIETSOUND = 14;
const int PERC_OBSERVESUSPECT   = 25;

const int GIL_SEPERATOR_HUM = 16; // Is fixed by the program

// Re-define the C_Focus class under different name
class GFA_C_Focus {
    var float npc_longrange;
    var float npc_range1, npc_range2;
    var float npc_azi;
    var float npc_elevdo, npc_elevup;
    var int npc_prio;
    var float item_range1, item_range2;
    var float item_azi;
    var float item_elevdo, item_elevup;
    var int item_prio;
    var float mob_range1, mob_range2;
    var float mob_azi;
    var float mob_elevdo, mob_elevup;
    var int mob_prio;
};

// Expect underlying instance by exact name
instance Focus_Ranged(GFA_C_Focus);
instance Focus_Magic(GFA_C_Focus);

// Daedalus black magic (do not try this at home): Require a symbol but do not overwrite
var int BS_FLAG_INTERRUPTABLE;
var int BS_FLAG_FREEHANDS;
var int BS_STAND;
var int BS_SNEAK;
var int BS_LIE;
var int BS_STUMBLE;
var int BS_MAX;
