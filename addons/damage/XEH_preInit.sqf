#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT "KAT - ADV Medical: Damage"

[
    QGVAR(enable),
    "CHECKBOX",
    LLSTRING(SETTING_Enable),
    [CBA_SETTINGS_CAT, ""],
    [true],
    true
] call CBA_Settings_fnc_init;

ADDON = true;