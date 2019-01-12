/*
 * Free aim menu options
 *
 * Gothic Free Aim (GFA) v1.1.0 - Free aiming for the video games Gothic 1 and Gothic 2 by Piranha Bytes
 * Copyright (C) 2016-2018  mud-freak (@szapp)
 *
 * This file is part of Gothic Free Aim.
 * <http://github.com/szapp/GothicFreeAim>
 *
 * Gothic Free Aim is free software: you can redistribute it and/or
 * modify it under the terms of the MIT License.
 * On redistribution this notice must remain intact and all copies must
 * identify the original author.
 *
 * Gothic Free Aim is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * MIT License for more details.
 *
 * You should have received a copy of the MIT License along with
 * Gothic Free Aim.  If not, see <http://opensource.org/licenses/MIT>.
 *
 *
 * Add these entries to the Menu_Opt_Game.d and adjust the indices:
 *  items[15] = "MENUITEM_OPT_GFA";
 *  items[16] = "MENUITEM_OPT_GFA_CHOICE";
 * Also in Menu_Opt_Game.d in MENUITEM_GAME_BACK change this:
 *  posy = MENU_BACK_Y+300;
 *
 * Adjust the item id (MENU_ID_GFA) below to the next available item number and change the labels if needed
 */


const int    MENU_ID_GFA  = 7;                              // Next available Y-spot in the game menu
const string MENU_GFA_LABEL   = "Freies Zielen";            // "Free aiming"
const string MENU_GFA_CHOICES = "aus|an";                   // "off|on"
const string MENU_GFA_DESCR   = "Erfordert Maus Steuerung"; // "Requires mouse controls"


// English
INSTANCE MENUITEM_OPT_EN_GFA(C_MENU_ITEM_DEF) {
    backpic         = MENU_ITEM_BACK_PIC;
    text[0]         = "Free aiming";
    text[1]         = "Requires mouse controls";
    posx            = 1000;                  posy = MENU_START_Y + MENU_SOUND_DY*MENU_ID_GFA;
    dimx            = 3000;                  dimy = 750;
    onSelAction[0]  = SEL_ACTION_UNDEF;
    flags           = flags | IT_EFFECTS_NEXT;
};


INSTANCE MENUITEM_OPT_EN_GFA_CHOICE(C_MENU_ITEM_DEF) {
    backPic               = MENU_CHOICE_BACK_PIC;
    type                  = MENU_ITEM_CHOICEBOX;
    text[0]               = "off|balanced|realistic";
    fontName              = MENU_FONT_SMALL;
    posx                  = 5000;            posy = MENU_START_Y + MENU_SOUND_DY*MENU_ID_GFA + MENU_CHOICE_YPLUS;
    dimx                  = MENU_SLIDER_DX;  dimy = MENU_CHOICE_DY;
    onChgSetOption        = "freeAimingEnabled";
    onChgSetOptionSection = "GFA";
    flags                 = flags & ~IT_SELECTABLE;
    flags                 = flags  | IT_TXT_CENTER;
};


// German
INSTANCE MENUITEM_OPT_DE_GFA(C_MENU_ITEM_DEF) {
    backpic         = MENU_ITEM_BACK_PIC;
    text[0]         = "Freies Zielen";
    text[1]         = "Erfordert Maus Steuerung";
    posx            = 1000;                  posy = MENU_START_Y + MENU_SOUND_DY*MENU_ID_GFA;
    dimx            = 3000;                  dimy = 750;
    onSelAction[0]  = SEL_ACTION_UNDEF;
    flags           = flags | IT_EFFECTS_NEXT;
};


INSTANCE MENUITEM_OPT_DE_GFA_CHOICE(C_MENU_ITEM_DEF) {
    backPic               = MENU_CHOICE_BACK_PIC;
    type                  = MENU_ITEM_CHOICEBOX;
    text[0]               = "aus|balanciert|realistisch";
    fontName              = MENU_FONT_SMALL;
    posx                  = 5000;            posy = MENU_START_Y + MENU_SOUND_DY*MENU_ID_GFA + MENU_CHOICE_YPLUS;
    dimx                  = MENU_SLIDER_DX;  dimy = MENU_CHOICE_DY;
    onChgSetOption        = "freeAimingEnabled";
    onChgSetOptionSection = "GFA";
    flags                 = flags & ~IT_SELECTABLE;
    flags                 = flags  | IT_TXT_CENTER;
};


// Polish
INSTANCE MENUITEM_OPT_PL_GFA(C_MENU_ITEM_DEF) {
    backpic         = MENU_ITEM_BACK_PIC;
    text[0]         = "Wolne Celowanie";
    text[1]         = "Wymaga sterowanie myszy.";
    posx            = 1000;                  posy = MENU_START_Y + MENU_SOUND_DY*MENU_ID_GFA;
    dimx            = 4000;                  dimy = 750;
    onSelAction[0]  = SEL_ACTION_UNDEF;
    flags           = flags | IT_EFFECTS_NEXT;
};


INSTANCE MENUITEM_OPT_PL_GFA_CHOICE(C_MENU_ITEM_DEF) {
    backPic               = MENU_CHOICE_BACK_PIC;
    type                  = MENU_ITEM_CHOICEBOX;
    text[0]               = "wy�.|zr�wnow.|realistyc.";
    fontName              = MENU_FONT_SMALL;
    posx                  = 5000;            posy = MENU_START_Y + MENU_SOUND_DY*MENU_ID_GFA + MENU_CHOICE_YPLUS;
    dimx                  = MENU_SLIDER_DX;  dimy = MENU_CHOICE_DY;
    onChgSetOption        = "freeAimingEnabled";
    onChgSetOptionSection = "GFA";
    flags                 = flags & ~IT_SELECTABLE;
    flags                 = flags  | IT_TXT_CENTER;
};


// Russian
INSTANCE MENUITEM_OPT_RU_GFA(C_MENU_ITEM_DEF) {
    backpic         = MENU_ITEM_BACK_PIC;
    text[0]         = "��������� ������������";
    text[1]         = "��������� ���������� �����.";
    posx            = 350;                   posy = MENU_START_Y + MENU_SOUND_DY*MENU_ID_GFA;
    dimx            = 5550;                  dimy = 750;
    onSelAction[0]  = SEL_ACTION_UNDEF;
    flags           = flags | IT_EFFECTS_NEXT;
};


INSTANCE MENUITEM_OPT_RU_GFA_CHOICE(C_MENU_ITEM_DEF) {
    backPic               = MENU_CHOICE_BACK_PIC;
    type                  = MENU_ITEM_CHOICEBOX;
    text[0]               = "����|������.|���������.";
    fontName              = MENU_FONT_SMALL;
    posx                  = 5900;            posy = MENU_START_Y + MENU_SOUND_DY*MENU_ID_GFA + MENU_CHOICE_YPLUS;
    dimx                  = MENU_SLIDER_DX;  dimy = MENU_CHOICE_DY;
    onChgSetOption        = "freeAimingEnabled";
    onChgSetOptionSection = "GFA";
    flags                 = flags & ~IT_SELECTABLE;
    flags                 = flags  | IT_TXT_CENTER;
};
