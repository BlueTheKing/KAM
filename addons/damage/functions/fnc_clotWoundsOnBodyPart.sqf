#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle clotting wounds on body part
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 * 2: Usable Clotting Factors <INT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, "leftleg", 12] call kat_damage_fnc_clotWoundsOnBodyPart;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", ["_clottingFactors", 12]];

private _fnc_getWoundsToTreat = {
    params ["_woundsList"];

    private _lowestID = 99;
    private _woundIndex = -1;

    {
        _x params ["_id", "_amountOf", "_bleeding"];

        private _severityID = _id % 10;
        if (_severityID < (_lowestID % 10) && _amountOf > 0 && _bleeding > 0) then {
            _lowestID = _id;
            _woundIndex = _forEachIndex;
        };        
    } forEach _woundsList;

    _woundIndex;
};

private _openWounds = GET_OPEN_WOUNDS(_patient);
private _openWoundsOnPart = _openWounds getOrDefault [_bodyPart, []];

private _woundIndex = [_openWoundsOnPart] call _fnc_getWoundsToTreat;

if (_woundIndex isEqualTo -1) exitWith {};

private _openWoundEntry = _openWoundsOnPart select _woundIndex;

_openWoundEntry params ["_woundID", "_woundCount", "_woundBleeding", "_woundDamage"];

private _woundSeverity = _woundID % 10;
_clottingFactors = _clottingFactors / (_woundSeverity + 1);

private _woundsRemaining = _woundCount - _clottingFactors;
private _amountClotted = _clottingFactors;

if (_woundsRemaining < 0) then {
    _woundsRemaining = 0;
    _amountClotted = _woundCount;
};

private _clottedWounds = GET_CLOTTED_WOUNDS(_patient);
private _clottedWoundsOnPart = _clottedWounds getOrDefault [_bodyPart, []];
private _clottedWoundEntry = [_woundID, _woundCount, _woundBleeding, _woundDamage];
_clottedWoundEntry set [1, _amountClotted];

_clottedWoundEntry params ["_clottedID"];

// Handle incrementing or creating new entry for clotted wounds
if (_clottedWoundsOnPart isEqualTo []) then {
    _clottedWoundsOnPart insert [-1, [_clottedWoundEntry]];
} else {
    private _foundIndex = _clottedWoundsOnPart findIf {(_x select 0) isEqualTo _clottedID};

    if (_foundIndex isEqualTo -1) then {
        _clottedWoundsOnPart insert [-1, [_clottedWoundEntry]];
    } else {
        private _foundClottedWoundEntry = _clottedWoundsOnPart select _foundIndex;
        _foundClottedWoundEntry params ["_id", "_amountOf", "_bleeding", "_damage"];
        private _newClottedEntry = [_id, (_amountOf + _amountClotted), _bleeding, _damage];
        _clottedWoundsOnPart set [_foundIndex, _newClottedEntry];
    };
};

_clottedWounds set [_bodyPart, _clottedWoundsOnPart];
_patient setVariable [VAR_CLOTTED_WOUNDS, _clottedWounds, true];

_clottingFactors = _clottingFactors - _amountClotted;

_openWoundEntry set [1, _woundsRemaining];
_openWoundsOnPart set [_woundIndex, _openWoundEntry];
_openWounds set [_bodyPart, _openWoundsOnPart];

_patient setVariable [VAR_OPEN_WOUNDS, _openWounds, true];

if (_clottingFactors > 0) then { // Use remaining clot factors
    [_patient, _bodyPart, _clottingFactors] call FUNC(clotWoundsOnBodyPart);
} else {
    [_patient] call ACEFUNC(medical_status,updateWoundBloodLoss);
};