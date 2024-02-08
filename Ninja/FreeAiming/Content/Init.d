/*
 * Menu initialization function called by Ninja every time a menu is opened
 */
func void Ninja_FreeAiming_Menu(var int menuPtr) {
    MEM_InitAll();

    // Check if GFA is already installed
    const int once = 0;
    if (!once) {
        if (MEM_GetSymbolIndex("GFA_Init") < Ninja_Symbols_Start_FreeAiming) {
            MEM_SendToSpy(zERR_TYPE_FATAL,
                          "Gothic Free Aim [GFA] is already installed. Remove the Free Aiming patch to continue.");
            return;
        };
        once = 1;
    };

    // Modify each menu by its name
    var zCMenu menu; menu = _^(menuPtr);
    if (Hlp_StrCmp(menu.name, "MENU_OPT_GAME"))
    || (Hlp_StrCmp(menu.name, "MENU_OPT_GAMEPLAY_GAME")) {
        var int items; items = _@(menu.m_listItems_array); // C_MENU_DEF.items[]
        Patch_GFA_AdjustGameMenu(items);
    };
};


/*
 * Initialization function called by Ninja after "Init_Global" (G2) / "Init_<Levelname>" (G1)
 */
func void Ninja_FreeAiming_Init() {
    // Wrapper for "LeGo_Init" to ensure correct LeGo initialization without breaking the mod
    LeGo_MergeFlags(GFA_LEGO_FLAGS | LeGo_Draw3D);

    // Initialize GFA
    GFA_Init(GFA_ALL & ~GFA_REUSE_PROJECTILES);
};
