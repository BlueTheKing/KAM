#include "..\script_component.hpp"
/*
 * Author: kymckay
 * Modified: Blue
 * Prevents bandage actions from showing if selected body part isn't bleeding.
 * Toggles between showing all or only basic bandage action for advanced setting.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Treatment <STRING>
 *
 * Return Value:
 * Can Bandage <BOOL>
 *
 * Example:
 * [player, cursorTarget, "Head", "FieldDressing"] call ace_medical_treatment_fnc_canBandage;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_bandage"];
_bodyPart = toLower _bodyPart;

// If patient is swimming, don't allow bandage actions.
if (_patient call ACEFUNC(common,isSwimming)) exitWith {false};

private _KAMBandages = ["PressureBandage","EmergencyTraumaDressing","ElasticWrap"];

if ((GVAR(enable) && !(_bandage in _KAMBandages)) || (!(GVAR(enable)) && (_bandage in _KAMBandages))) exitWith {false};

// Bandage type and bandage setting XNOR to show only active actions
if ((_bandage == "BasicBandage") isEqualTo (ACEGVAR(medical_treatment,advancedBandages) != 0)) exitWith {false};

private _canBandage = false;

{
    _x params ["_id", "_amountOf", "_bleeding"];

    // If any single wound on the bodypart is bleeding bandaging can go ahead
    if (_amountOf * _bleeding > 0 && {_bandage isNotEqualTo "ElasticWrap"}) exitWith {
        _canBandage = true;
    };

    if (!(_amountOf * _bleeding > 0) && {_bandage isEqualTo "ElasticWrap" && _id in [20,21,22]}) exitWith {  // Elastic Wrap can treat bruises
        _canBandage = true;
    };
} forEach ((GET_OPEN_WOUNDS(_patient)) getOrDefault [_bodyPart, []]);

_canBandage
