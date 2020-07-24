/*
 * Create menu item from script instance name
 */
func int Ninja_FreeAiming_CreateMenuItem(var string scriptName) {
    const int zCMenuItem__Create_G1 = 5052784; //0x4D1970
    const int zCMenuItem__Create_G2 = 5105600; //0x4DE7C0

    var int strPtr; strPtr = _@s(scriptName);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(strPtr));
        CALL_PutRetValTo(_@(ret));
        CALL__cdecl(MEMINT_SwitchG1G2(zCMenuItem__Create_G1, zCMenuItem__Create_G2));
        call = CALL_End();
    };

    var int ret;
    return +ret;
};


/*
 * Guess localization (0 = EN, 1 = DE, 2 = PL, 3 = RU)
 */
func int Ninja_FreeAiming_GuessLocalization() {
    var int pan; pan = MEM_GetSymbol("MOBNAME_PAN");
    if (pan) {
        var zCPar_Symbol panSymb; panSymb = _^(pan);
        var string panName; panName = MEM_ReadString(panSymb.content);
        if (Hlp_StrCmp(panName, "Pfanne")) { // DE
            return 1;
        } else if (Hlp_StrCmp(panName, "Patelnia")) { // PL
            return 2;
        } else if (Hlp_StrCmp(panName, "Сковорода")) { // RU
            return 3;
        };
    };
    return 0; // Otherwise EN
};


/*
 * C_CanNpcCollideWithSpell hook (Gothic 2 only)
 */
func int Ninja_FreeAiming_SPLCOLLIDE(var int spellType) {
    // Do not damage beyond maximum fighting range (AI does not react)
    if (Npc_GetDistToNpc(self, other) > Ninja_FreeAiming_FIGHT_DIST_CANCEL) {
        return /*COLL_DONOTHING*/ 0;
    };

    // Otherwise continue as normal
    passArgumentI(spellType);
    ContinueCall();
};
