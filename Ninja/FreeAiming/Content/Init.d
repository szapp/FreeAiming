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


    // Get menu and menu item list, corresponds to the contents of C_MENU_DEF.items[]
    var zCMenu menu; menu = _^(menuPtr);
    var int items; items = _@(menu.m_listItems_array);


    // Modify each menu by its name
    if (Hlp_StrCmp(menu.name, "MENU_OPT_GAME"))
    || (Hlp_StrCmp(menu.name, "MENU_OPT_GAMEPLAY_GAME")) {

        // Guess language
        var string itm1Str; var string itm2Str;
        var int loc; loc = Patch_FreeAiming_GuessLocalization();
        if (loc == 0) {
            itm1Str = "MENUITEM_OPT_EN_GFA";
            itm2Str = "MENUITEM_OPT_EN_GFA_CHOICE";
        } else if (loc == 1) {
            itm1Str = "MENUITEM_OPT_DE_GFA";
            itm2Str = "MENUITEM_OPT_DE_GFA_CHOICE";
        } else if (loc == 2) {
            itm1Str = "MENUITEM_OPT_PL_GFA";
            itm2Str = "MENUITEM_OPT_PL_GFA_CHOICE";
        } else if (loc == 3) {
            itm1Str = "MENUITEM_OPT_RU_GFA";
            itm2Str = "MENUITEM_OPT_RU_GFA_CHOICE";
        };

        // Get bottom most menu item and new menu items
        var int itmL; itmL = MEM_ArrayPop(items); // Typically "BACK"
        var int itm1; itm1 = MEM_GetMenuItemByString(itm1Str);
        var int itm2; itm2 = MEM_GetMenuItemByString(itm2Str);

        // If the new ones do not exist yet, create them the first time
        if (!itm1) {
            var zCMenuItem itmNew;
            var zCMenuItem itm;
            itm1 = Patch_FreeAiming_CreateMenuItem(itm1Str);
            itm2 = Patch_FreeAiming_CreateMenuItem(itm2Str);

            // Align appearance of left menu item to the existing entry
            repeat(index, MEM_ArraySize(items)); var int index;
                // Find an existing left column entry
                itm = _^(MEM_ArrayRead(items, index));
                if (itm.m_parType == /*MENU_ITEM_TEXT*/ 1)
                && (itm.m_parItemFlags & /*IT_EFFECTS_NEXT*/ 128) {
                    break;
                };
            end;
            itmNew = _^(itm1);
            itmNew.m_parPosX    = itm.m_parPosX;
            itmNew.m_pFont      = itm.m_pFont;
            itmNew.m_pFontSel   = itm.m_pFontSel;
            itmNew.m_parBackPic = itm.m_parBackPic;

            // Align appearance of right menu item to the existing entry
            repeat(index, MEM_ArraySize(items));
                // Find an existing right column entry
                itm = _^(MEM_ArrayRead(items, index));
                if (itm.m_parType != /*MENU_ITEM_TEXT*/ 1)
                && (!(itm.m_parItemFlags & /*IT_SELECTABLE*/ 4)) {
                    break;
                };
            end;
            itmNew = _^(itm2);
            itmNew.m_parPosX    = itm.m_parPosX;
            itmNew.m_pFont      = itm.m_pFont;
            itmNew.m_pFontSel   = itm.m_pFontSel;
            itmNew.m_parBackPic = itm.m_parBackPic;

            // Also adjust vertical positions of the menu items
            itm = _^(itmL);
            var int y; y = itm.m_parPosY;
            itm.m_parPosY = y+300; // Move bottom item down

            itm = _^(itm1);
            itm.m_parPosY = y-250; // Move new item 1 up

            itm = _^(itm2);
            itm.m_parPosY = y-130; // Move new item 2 up
        };

        // (Re-)insert the menu items in the correct order
        MEM_ArrayInsert(items, itm1);
        MEM_ArrayInsert(items, itm2);
        MEM_ArrayInsert(items, itmL);
    };

    /* Modify other menus as well:
     .. else if (Hlp_StrCmp(menu.name, "XXXX")) {

        // ...

    }; */
};


/*
 * Initialization function called by Ninja after "Init_Global" (G2) / "Init_<Levelname>" (G1)
 */
func void Ninja_FreeAiming_Init() {
    // Wrapper for "LeGo_Init" to ensure correct LeGo initialization without breaking the mod
    LeGo_MergeFlags(GFA_LEGO_FLAGS);

    // Initialize GFA
    GFA_Init(GFA_ALL & ~GFA_REUSE_PROJECTILES);

    // Inject changes into C_CanNpcCollideWithSpell
    if (GOTHIC_BASE_VERSION == 2) {
        HookDaedalusFuncS("C_CanNpcCollideWithSpell", "Patch_FreeAiming_SPLCOLLIDE");
    };

    // Request dependencies
    Patch_FreeAiming_FillConstants();
};
