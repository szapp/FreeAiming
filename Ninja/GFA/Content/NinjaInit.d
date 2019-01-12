/*
 * Call this function (from the function "Ninja_GFA_Init" below) to initialize LeGo packages.
 *
 * It ensures that all necessary LeGo packages will be loaded without breaking already loaded LeGo packages.
 *
 * Caution: When re-using this function elsewhere, it is important to rename it to prevent clashes!
 * Each Ninja patch that needs it, has to have their own function with a unique name. Otherwise they cannot be stacked.
 *
 * Do not modify this function in any way!
 */
func void Ninja_GFA_MergeLeGoFlags(var int flags) {
    const int legoInit    = -1; // Prior initialization state
    const int initialized =  0; // Once per session
    var   int loaded;           // Once per game save
    legoInit    = LeGo_MergeFlags(flags, legoInit, initialized, loaded);
    initialized = 1;
    loaded      = 1;
};


/*
 * Menu initialization function called by Ninja every time a menu is opened
 */
func void Ninja_GFA_Menu(var int menuPtr) {
    MEM_InitAll();

    // Get menu and menu item list, corresponds to the contents of C_MENU_DEF.items[]
    var zCMenu menu; menu = _^(menuPtr);
    var int items; items = _@(menu.m_listItems_array);


    // Modify each menu by its name
    if (Hlp_StrCmp(menu.name, "MENU_OPT_GAME")) {

        // Guess language
        var string itm1Str; var string itm2Str;
        var int loc; loc = Ninja_GFA_GuessLocalization();
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
            itm1 = Ninja_GFA_CreateMenuItem(itm1Str);
            itm2 = Ninja_GFA_CreateMenuItem(itm2Str);

            // Also adjust vertical positions of the menu items
            var zCMenuItem itm;
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
func void Ninja_GFA_Init() {
    // Wrapper for "LeGo_Init" to ensure correct LeGo initialization without breaking the mod
    Ninja_GFA_MergeLeGoFlags(GFA_LEGO_FLAGS);

    // Initialize GFA
    GFA_Init(GFA_ALL & ~GFA_REUSE_PROJECTILES);

    // Inject changes into C_CanNpcCollideWithSpell
    if (GOTHIC_BASE_VERSION == 2) {
        HookDaedalusFuncS("C_CanNpcCollideWithSpell", "Ninja_GFA_SPLCOLLIDE");
    };
};
