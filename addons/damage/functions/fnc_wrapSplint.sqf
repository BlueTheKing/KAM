#include "..\script_component.hpp"
/*
 * Author: Blue
 * Wrap splint
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
 * [player, cursorTarget, "leftleg"] call kat_damage_fnc_wrapSplint;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

private _splintStatus = GET_SPLINTS(_patient);
private _splintStatusOnPart = _splintStatus select (ALL_BODY_PARTS find toLower _bodyPart);

_splintStatus set [(ALL_BODY_PARTS find toLower _bodyPart), 2];

_patient setVariable [VAR_SPLINTS, _splintStatus, true];

[_patient, "activity", "%1 wrapped a splint", [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);

// Splint falls off after a while
[{
    params ["_patient", "_bodyPart"];

    GET_SPLINTS(_patient) select (ALL_BODY_PARTS find toLower _bodyPart) != 2;
}, {}, [_patient, _bodyPart], random [900, 1150, 1200], {
    params ["_patient", "_bodyPart"];

    [objNull, _patient, _bodyPart] call FUNC(removeSplintLocal);
    ["Splint has fallen off", 1.5, _patient] call ACEFUNC(common,displayTextStructured);
}] call CBA_fnc_waitUntilAndExecute;