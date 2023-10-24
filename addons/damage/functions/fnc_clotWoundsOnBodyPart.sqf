#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle clotting wounds on body part
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 * 2: Usable Clotting Factors <INT>
 * 3: Clots are unstable <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, "leftleg", 12] call kat_damage_fnc_clotWoundsOnBodyPart;
 *
 * Public: No
 */

params ["_patient", "_bodyPart", ["_clottingFactors", 12], ["_unstable", true]];

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

private _fnc_handleReopening = {
    params ["_patient", "_bodyPart", "_id", "_unstable"];

    private _delay = random [150, 180, 210];

    if !(_unstable) then {
        _delay = random [600, 900, 1200];
    };

    [{
        params ["_patient", "_bodyPart", "_id"];
        
        private _clottedWounds = GET_CLOTTED_WOUNDS(_patient);
        private _clottedWoundsOnPart = _clottedWounds getOrDefault [_bodyPart, []];

        private _clottedIndex = _clottedWoundsOnPart findIf {(_x select 0) isEqualTo _id && {(_x select 1) > 0}};

        if (_clottedIndex isEqualTo -1) exitWith {};

        (_clottedWoundsOnPart select _clottedIndex) params ["", "_clottedAmountOf", "_clottedBleeding", "_clottedDamage"];
        
        private _clottedWound = [_id, ((_clottedAmountOf - 1) max 0), _clottedBleeding, _clottedDamage];

        _clottedWoundsOnPart set [_clottedIndex, _clottedWound];
        _clottedWounds set [_bodyPart, _clottedWoundsOnPart];
        
        _patient setVariable [VAR_CLOTTED_WOUNDS, _clottedWounds, true];

        private _openWounds = GET_OPEN_WOUNDS(_patient);
        private _openWoundsOnPart = _openWounds getOrDefault [_bodyPart, []];

        private _index = _openWoundsOnPart findIf {(_x select 0) isEqualTo _id};

        if (_index isEqualTo -1) exitWith {};

        (_openWoundsOnPart select _index) params ["", "_woundAmountOf", "_woundBleeding", "_woundDamage"];

        private _openWound = [_id, (_woundAmountOf + 1), _woundBleeding, _woundDamage];
        _openWoundsOnPart set [_index, _openWound];
        _openWounds set [_bodyPart, _openWoundsOnPart];

        _patient setVariable [VAR_OPEN_WOUNDS, _openWounds, true];

        private _partIndex = ALL_BODY_PARTS find _bodyPart;

        switch (_partIndex) do {
            case 0: { [_patient, true, false, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
            case 1: { [_patient, false, true, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
            case 2;
            case 3: { [_patient, false, false, true, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
            default { [_patient, false, false, false, true] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        };
    }, [_patient, _bodyPart, _id, _unstable], _delay] call CBA_fnc_waitAndExecute;
};

private _openWounds = GET_OPEN_WOUNDS(_patient);
private _openWoundsOnPart = _openWounds getOrDefault [_bodyPart, []];

private _woundIndex = [_openWoundsOnPart] call _fnc_getWoundsToTreat;

if (_woundIndex isEqualTo -1) exitWith {};

(_openWoundsOnPart select _woundIndex) params ["_woundID", "_woundCount", "_woundBleeding", "_woundDamage"];
private _openWoundEntry = [_woundID, _woundCount, _woundBleeding, _woundDamage];

private _woundSeverity = _woundID % 10;
_clottingFactors = _clottingFactors / (_woundSeverity + 1);

private _woundsRemaining = _woundCount - _clottingFactors;
private _amountClotted = _clottingFactors;

if (_woundsRemaining < 0) then { // TODO use min/max
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
        _clottedWoundsOnPart set [_foundIndex, [_id, (_amountOf + _amountClotted), _bleeding, _damage]];
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

private _reopenChance = 0.6;
private _txaCount = [_patient, "TXA"] call ACEFUNC(medical_status,getMedicationCount);

if (_txaCount > 0 || !_unstable) then {
    _reopenChance = 0.5;
};

for "_i" from 1 to _amountClotted do {
    if ((random 1) < _reopenChance) then {
        [_patient, _bodyPart, _clottedID, _unstable] call _fnc_handleReopening;
    };
};