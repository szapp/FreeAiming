/*
 * Re-write common constants that might be missing in mods
 * ONLY DEFINE CONSTANTS THAT HAVE DEFINITELY ALWAYS THE SAME VALUES!
 */
const int GFA_IDX_EXE   = 2; // Game version index

const int ATR_STRENGTH  = 4;
const int ATR_DEXTERITY = 5;

const int FMODE_NONE    = 0;
const int FMODE_FIST    = 1;
const int FMODE_MELEE   = 2;
const int FMODE_FAR     = 5; // Sequel 6
const int FMODE_MAGIC   = 7; // Sequel 8

const int PROT_POINT    = 6;

const int ITEM_KAT_MUN  = 1 << 3;
const int ITEM_BOW      = 1 << 19;
const int ITEM_CROSSBOW = 1 << 20;

const int NPC_TALENT_BOW      = 3; // Sequel 5
const int NPC_TALENT_CROSSBOW = 4; // Sequel 5

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

instance Focus_Normal(C_Focus);
instance Focus_Melee(C_Focus);
instance Focus_Ranged(C_Focus);
instance Focus_Throw_Item(C_Focus);
instance Focus_Throw_Mob(C_Focus);
instance Focus_Magic(C_Focus);
