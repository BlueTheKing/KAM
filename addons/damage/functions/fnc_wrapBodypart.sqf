#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle wrapping wounds/bandages on body part
 *
 * Arguments:
 * 0: Medic (not used) <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Wrappable Type <INT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "head", 1] call kat_damage_fnc_wrapBodyPart;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_type"];

private _fnc_handleReopening = {
    params ["_patient", "_bodyPart", "_id", "_bleeding"];

    private _delay = [900, 1050, 1200];

    [{
        params ["_patient", "_bodyPart", "_id", "_bleeding"];

        private _openWounds = GET_OPEN_WOUNDS(_patient);
        private _openWoundsOnPart = _openWounds getOrDefault [_bodyPart, []];

        private _index = _openWoundsOnPart findIf {(_x select 0) isEqualTo _id};

        if (_index isEqualTo -1) exitWith {};

        (_openWoundsOnPart select _index) params ["", "_woundAmountOf", "", "_damage"];

        private _openWound = [_id, (_woundAmountOf + 1), _bleeding, _damage];
        _openWoundsOnPart set [_index, _openWound];
        _openWounds set [_bodyPart, _openWoundsOnPart];

        _patient setVariable [VAR_OPEN_WOUNDS, _openWounds, true];

        private _partIndex = ALL_BODY_PARTS find _bodyPart;

        switch (_partIndex) do {
            case 0: { [_target, true, false, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
            case 1: { [_target, false, true, false, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
            case 2;
            case 3: { [_target, false, false, true, false] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
            default { [_target, false, false, false, true] call ACEFUNC(medical_engine,updateBodyPartVisuals); };
        };

        if ((ACEGVAR(medical,limping) == 1) && {_partIndex > 3}) then {
            [_patient] call ACEFUNC(medical_engine,updateDamageEffects);
        };
    }, [_patient, _bodyPart, _id, _bleeding, _damage], _delay] call CBA_fnc_waitAndExecute;
};

private _wrappableList = createHashMap;
private _output = "bandages";

if (_type isEqualTo 1) then {
    _wrappableList = GET_CLOTTED_WOUNDS(_patient);
    _output = "clotted wounds";
} else {
    _wrappableList = GET_BANDAGED_WOUNDS(_patient);
};

private _wrappableListOnPart = _wrappableList getOrDefault [_bodyPart, []];

if (_wrappableListOnPart isEqualTo []) exitWith {};
private _openWounds = GET_OPEN_WOUNDS(_patient) getOrDefault [_bodyPart, []];

if (_openWounds isNotEqualTo [] && {[_patient, _bodyPart] call FUNC(isBodyPartBleeding)}) exitWith {}; // Can't wrap while wounds are bleeding

private _wrappedWounds = GET_WRAPPED_WOUNDS(_patient);
private _wrappedWoundsOnPart = _wrappedWounds getOrDefault [_bodyPart, []];

// Handle incrementing or creating new entry for wrapped wounds
if (_wrappedWoundsOnPart isEqualTo []) then { 
    _wrappedWounds set [_bodyPart, _wrappableListOnPart];
} else {
    {
        _x params ["_id", "_amountOf"];

        private _index = _wrappedWoundsOnPart findIf {_x select 0 isEqualTo _id};

        if (_index != -1) then {
            private _current = _wrappedWoundsOnPart select _index;
            _wrappedWoundsOnPart set [_index, [_current select 0, (_current select 1) + _amountOf, _current select 2, _current select 3]];
        } else {
            _wrappedWoundsOnPart insert [-1, [_x]];
        };
    } forEach _wrappableListOnPart;

    _wrappedWounds set [_bodyPart, _wrappedWoundsOnPart];
};

// handle reopening
{
    _x params ["_id", "_amountOf", "_bleeding", "_damage"];

    for "_i" from 1 to _amountOf do {
        if (random (ceil 100) < 50) then {
            [_patient, _bodyPart, _id, _bleeding] call _fnc_handleReopening;
        };
    };
} forEach _wrappableListOnPart;

_patient setVariable [VAR_WRAPPED_WOUNDS, _wrappedWounds, true];

_wrappableList deleteAt _bodyPart;

if (_type isEqualTo 1) then {
    _patient setVariable [VAR_CLOTTED_WOUNDS, _wrappableList, true];
} else {
    _patient setVariable [VAR_BANDAGED_WOUNDS, _wrappableList, true];
};

// Check if we fixed limping by wrapping this wound (only for leg wounds)
if (ACEGVAR(medical,limping) == 2 && {_patient getVariable [QACEGVAR(medical,isLimping), false]} && {_bodyPart in ["leftleg", "rightleg"]}) then {
    TRACE_3("Updating damage effects",_patient,_bodyPart,local _patient);
    [QACEGVAR(medical_engine,updateDamageEffects), _patient, _patient] call CBA_fnc_targetEvent;
};

[_patient, "activity", "%1 wrapped %2", [[_medic] call ACEFUNC(common,getName), _output]] call ACEFUNC(medical_treatment,addToLog);