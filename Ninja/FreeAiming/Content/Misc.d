/*
 * Create menu item from script instance name
 */
func int Patch_FreeAiming_CreateMenuItem(var string scriptName) {
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
func int Patch_FreeAiming_GuessLocalization() {
    var int pan; pan = MEM_GetSymbol("MOBNAME_PAN");
    if (pan) {
        var zCPar_Symbol panSymb; panSymb = _^(pan);
        var string panName; panName = MEM_ReadString(panSymb.content);
        if (Hlp_StrCmp(panName, "Pfanne")) {              // DE cp1252
            return 1;
        } else if (Hlp_StrCmp(panName, "Patelnia")) {     // PL cp1250
            return 2;
        } else if (Hlp_StrCmp(panName, "—ÍÓ‚ÓÓ‰‡")) {    // RU cp1251
            return 3;
        } else if (Hlp_StrCmp(panName, "Padella")) {      // IT cp1252
            return 4;
        } else if (Hlp_StrCmp(panName, "SartÈn")) {       // ES cp1252
            return 5;
        } else if (Hlp_StrCmp(panName, "Casserole")) {    // FR cp1252
            return 6;
        } else if (Hlp_StrCmp(panName, "P·nviËka")) {     // CS cp1250
            return 7;
        } else if (Hlp_StrCmp(panName, "Serpenyı")) {     // HU cp1250
            return 8;
        } else if (Hlp_StrCmp(panName, "Tigaie")) {       // RO cp1250
            return 9;
        } else if (Hlp_StrCmp(panName, "œ‡ÚÂÎ¸Ìˇ")) {     // UK cp1251
            return 10;
        } else if (Hlp_StrCmp(panName, "Tava")) {         // TR cp1254
            return 11;
        } else if (Hlp_StrCmp(panName, "Padell")) {       // CY
            return 12;
        } else if (Hlp_StrCmp(panName, "Âπ≥Â∫ïÈîÖ"))
               || (Hlp_StrCmp(panName, "Èçã")) {     // ZH
            return 13;
        };
    };
    return 0; // Otherwise EN
};
