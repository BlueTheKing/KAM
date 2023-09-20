#include "script_component.hpp"
/*
 * Author: Blue
 * Wrap bruise on body part
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "head"] call kat_damage_fnc_wrapBruise;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _woundsOnPart = GET_OPEN_WOUNDS(_patient) getOrDefault [_bodyPart, []];
if (_woundsOnPart isEqualTo []) exitWith {};

private _highestID = -1;
private _woundIndex = -1;
private _woundAmount = -1;

{
    _x params ["_id", "_amountOf"];

    if (_id in [20,21,22] && {_amountOf > 0} && {_id > _highestID}) then {
        _highestID = _id;
        _woundIndex = _forEachIndex;
        _woundAmount = _amountOf;
    };
} forEach _woundsOnPart;

if (_highestID isEqualTo -1) exitWith {};

private _bruiseEntry = _woundsOnPart select _woundIndex;
private _amountToRemove = 1;

switch (_highestID) do {
    case 20: {_amountToRemove = 4}; // small
    case 21: {_amountToRemove = 2}; // medium
    default {}; // large
};

_bruiseEntry set [1, ((_woundAmount - _amountToRemove) max 0)];
_woundsOnPart set [_woundIndex, _bruiseEntry];

private _wounds = GET_OPEN_WOUNDS(_patient);
_wounds set [_bodyPart, _woundsOnPart];

_patient setVariable [VAR_OPEN_WOUNDS, _wounds, true];

[_patient, "activity", "%1 wrapped %2", [[_medic] call ACEFUNC(common,getName), "bruises"]] call ACEFUNC(medical_treatment,addToLog);