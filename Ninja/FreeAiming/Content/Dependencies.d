/*
 * Re-write common constants that might be missing in mods
 * ONLY DEFINE CONSTANTS THAT HAVE DEFINITELY ALWAYS THE SAME VALUES!
 * Otherwise mod content will be overwritten, e.g. see FIGHT_DIST_CANCEL below
 */
const int ATR_STRENGTH  = 4;
const int ATR_DEXTERITY = 5;

const int FMODE_NONE    = 0;
const int FMODE_FIST    = 1;
const int FMODE_MELEE   = 2;
const int FMODE_FAR     = 5;
const int FMODE_MAGIC   = 7;

const int PROT_POINT    = 6;

const int ITEM_KAT_MUN  = 1 << 3;
const int ITEM_BOW      = 1 << 19;
const int ITEM_CROSSBOW = 1 << 20;
const int ITEM_NFOCUS   = 1 << 23;

const int NPC_TALENT_BOW      = 3;
const int NPC_TALENT_CROSSBOW = 4;

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

// Do not overwrite! Might have different value in mod: So change the name, and fill below
const int Ninja_FreeAiming_GIL_SEPERATOR_ORC = 0;
const int Ninja_FreeAiming_FIGHT_DIST_CANCEL = 3500;

func void Ninja_FreeAiming_FillConstants() {
    var int symbPtr;
    var zCPar_Symbol symb;

    symbPtr = MEM_GetSymbol("FIGHT_DIST_CANCEL");
    if (symbPtr) {
        symb = _^(symbPtr);
        Ninja_FreeAiming_FIGHT_DIST_CANCEL = symb.content;
    };

    symbPtr = MEM_GetSymbol("GIL_SEPERATOR_ORC");
    if (symbPtr) {
        symb = _^(symbPtr);
        Ninja_FreeAiming_GIL_SEPERATOR_ORC = symb.content;
    } else {
        Ninja_FreeAiming_GIL_SEPERATOR_ORC = MEMINT_SwitchG1G2(37, 58);
    };
};

// Safer way to check, because guilds might not exist
func int Ninja_FreeAiming_NpcIsUndead(var C_Npc slf) {
    var int symbPtr;
    var zCPar_Symbol symb;

    // if (slf.guild == GIL_ZOMBIE)
    symbPtr = MEM_GetSymbol("GIL_ZOMBIE");
    if (symbPtr) {
        symb = _^(symbPtr);
        if (slf.guild == symb.content) {
            return TRUE;
        };
    };

    // if (slf.guild == GIL_UNDEADORC)
    symbPtr = MEM_GetSymbol("GIL_UNDEADORC");
    if (symbPtr) {
        symb = _^(symbPtr);
        if (slf.guild == symb.content) {
            return TRUE;
        };
    };

    // if (slf.guild == GIL_SKELETON)
    symbPtr = MEM_GetSymbol("GIL_SKELETON");
    if (symbPtr) {
        symb = _^(symbPtr);
        if (slf.guild == symb.content) {
            return TRUE;
        };
    };

    return FALSE;
};

// Might not exist, make a simpler version of it here
func int Ninja_FreeAiming_BodyStateContains(var C_Npc slf, var int bodystate) {
    bodystate = (bodystate & (BS_MAX|BS_FLAG_INTERRUPTABLE|BS_FLAG_FREEHANDS));
    return ((Npc_GetBodyState(slf) & (BS_MAX|BS_FLAG_INTERRUPTABLE|BS_FLAG_FREEHANDS)) == bodystate);
};

// Might not exist
func int Ninja_FreeAiming_C_NpcIsDown(var C_NPC slf) {
    var int symbPtr;
    var zCPar_Symbol symb;
    var MEMINT_HelperClass f;

    // if (Npc_IsInState(slf, ZS_Unconscious)
    symbPtr = MEM_GetSymbol("ZS_Unconscious");
    if (symbPtr) {
        symb = _^(symbPtr);
        MEM_PushInstParam(slf);
        symb.content;
        MEM_Call(Npc_IsInState);
        if (MEM_PopIntResult()) {
            return TRUE;
        };
    };

    // if (Npc_IsInState(slf, ZS_MagicSleep)
    symbPtr = MEM_GetSymbol("ZS_MagicSleep");
    if (symbPtr) {
        symb = _^(symbPtr);
        MEM_PushInstParam(slf);
        symb.content;
        MEM_Call(Npc_IsInState);
        if (MEM_PopIntResult()) {
            return TRUE;
        };
    };

    return Npc_IsDead(slf);
};
