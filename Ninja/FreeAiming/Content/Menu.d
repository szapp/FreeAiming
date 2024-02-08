/*
 * Create menu item from script instance name
 * Source: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func int Patch_GFA_CreateMenuItem(var string scriptName) {
    const int zCMenuItem__Create[4] = { 5052784, 5120352, 5094928, 5105600 };

    if (CALL_Begin(call)) {
        const int call = 0;
        const int ret = 0;
        const int strPtr = 0;
        strPtr = _@s(scriptName);
        CALL_PtrParam(_@(strPtr));
        CALL_PutRetValTo(_@(ret));
        CALL__cdecl(zCMenuItem__Create[IDX_EXE]);
        call = CALL_End();
    };

    return +ret;
};


/*
 * Set localization indicator in menu scripts
 * Adjusted from: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func void Patch_GFA_UpdateMenuString(var string symbolName, var string content) {
    const int zCPar_SymbolTable__GetSymbol[4] = { 7316336, 7554816, 7619584, 8011328 };
    var int symTab; symTab = MEM_ReadInt(menuParserPointerAddress) + 16;

    if (CALL_Begin(call)) {
        const int call = 0;
        const int namePtr = 0;
        const int symbPtr = 0;
        namePtr = _@s(symbolName);
        CALL_PtrParam(_@(namePtr));
        CALL_PutRetValTo(_@(symbPtr));
        CALL__thiscall(_@(symTab), zCPar_SymbolTable__GetSymbol[IDX_EXE]);
        call = CALL_End();
    };

    if (symbPtr) {
        var zCPar_Symbol symb; symb = _^(symbPtr);
        MEM_WriteString(symb.content, content);
    };
};


/*
 * Guess localization
 * Indices are assigned in no particular order (new ones added at the end)
 *
 * EN =  0 (default)
 * DE =  1
 * PL =  2
 * RU =  3
 * IT =  4
 * ES =  5
 * FR =  6
 * CS =  7
 * HU =  8
 * RO =  9
 * UK = 10
 * TR = 11
 * CY = 12
 * ZH = 13
 */
func int Patch_GFA_GuessLocalization() {
    var int pan; pan = MEM_GetSymbol("MOBNAME_PAN");
    if (pan) {
        var zCPar_Symbol panSymb; panSymb = _^(pan);
        var string panName; panName = MEM_ReadString(panSymb.content);
        if (Hlp_StrCmp(panName, "Pfanne")) {              // DE cp1252
            return 1;
        } else if (Hlp_StrCmp(panName, "Patelnia")) {     // PL cp1250
            return 2;
        } else if (Hlp_StrCmp(panName, "Ñêîâîðîäà")) {    // RU cp1251
            return 3;
        } else if (Hlp_StrCmp(panName, "Padella")) {      // IT cp1252
            return 4;
        } else if (Hlp_StrCmp(panName, "Sartén")) {       // ES cp1252
            return 5;
        } else if (Hlp_StrCmp(panName, "Casserole")) {    // FR cp1252
            return 6;
        } else if (Hlp_StrCmp(panName, "Pánvièka")) {     // CS cp1250
            return 7;
        } else if (Hlp_StrCmp(panName, "Serpenyõ")) {     // HU cp1250
            return 8;
        } else if (Hlp_StrCmp(panName, "Tigaie")) {       // RO cp1250
            return 9;
        } else if (Hlp_StrCmp(panName, "Ïàòåëüíÿ")) {     // UK cp1251
            return 10;
        } else if (Hlp_StrCmp(panName, "Tava")) {         // TR cp1254
            return 11;
        } else if (Hlp_StrCmp(panName, "Padell")) {       // CY
            return 12;
        } else if (Hlp_StrCmp(panName, "å¹³åº•é”…"))
               || (Hlp_StrCmp(panName, "é‹")) {     // ZH
            return 13;
        };
    };
    return 0; // Otherwise EN
};


/*
 * Adjust game menu
 * Adjusted from: https://github.com/szapp/Ninja/wiki/Inject-Changes
 */
func void Patch_GFA_AdjustGameMenu(var int items) {
    const int MENU_ITEM_TEXT  = 1;
    const int IT_SELECTABLE   = 4;
    const int IT_EFFECTS_NEXT = 128;

    var string itm1Str; itm1Str = "MENUITEM_OPT_GFA";
    var string itm2Str; itm2Str = "MENUITEM_OPT_GFA_CHOICE";

    // Get bottom most menu item and new menu items
    var int itmL; itmL = MEM_ArrayPop(items); // Typically "BACK"
    var int itm1; itm1 = MEM_GetMenuItemByString(itm1Str);
    var int itm2; itm2 = MEM_GetMenuItemByString(itm2Str);

    // If the new ones do not exist yet, create them the first time
    if (!itm1) {
        // First overwrite the localization
        var int loc; loc = Patch_GFA_GuessLocalization();
        if (loc >= PATCH_GFA_MENU_LANG_MAX) { loc = 0; }; // Limited language support
        Patch_GFA_UpdateMenuString("GFA_MENU_LABEL",   MEM_ReadStatStringArr(PATCH_GFA_MENU_LABEL, loc));
        Patch_GFA_UpdateMenuString("GFA_MENU_CHOICES", MEM_ReadStatStringArr(PATCH_GFA_MENU_CHCES, loc));
        Patch_GFA_UpdateMenuString("GFA_MENU_DESCR",   MEM_ReadStatStringArr(PATCH_GFA_MENU_DESCR, loc));

        var zCMenuItem itmNew;
        var zCMenuItem itm;
        itm1 = Patch_GFA_CreateMenuItem(itm1Str);
        itm2 = Patch_GFA_CreateMenuItem(itm2Str);

        // Align appearance of left menu item to the existing entry
        repeat(index, MEM_ArraySize(items)); var int index;
            // Find an existing left column entry
            itm = _^(MEM_ArrayRead(items, index));
            if (itm.m_parType == MENU_ITEM_TEXT)
            && (itm.m_parItemFlags & IT_EFFECTS_NEXT) {
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
            if (itm.m_parType != MENU_ITEM_TEXT)
            && (!(itm.m_parItemFlags & IT_SELECTABLE)) {
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
