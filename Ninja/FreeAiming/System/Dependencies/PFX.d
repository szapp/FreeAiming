/*
 * Re-define the menu item class because it is not guaranteed that it exists in every mod.
 * Note, that the original class/prototype are not overwritten but unique symbol names are used.
 */

// Exception: The class C_ParticleFX is special and has to exist
prototype GFA_C_ParticleFX(C_ParticleFX) {};
