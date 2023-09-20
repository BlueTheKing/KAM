#include "script_component.hpp"
/*
 * Author: Blue
 * Remove splint from limb
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
 * [player, cursorTarget, "leftleg"] call kat_damage_fnc_removeSplintLocal;
 *
 * Public: No
 */

params [["_medic", objNull], "_patient", "_bodyPart"];

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;

private _splintStatus = GET_SPLINTS(_patient);

private _fractures = GET_FRACTURES(_patient);
_fractures set [_partIndex, 1];
_patient setVariable [VAR_FRACTURES, _fractures, true];

_splintStatus set [_partIndex, 0];
_patient setVariable [VAR_SPLINTS, _splintStatus, true];

[_patient] call ACEFUNC(medical_engine,updateDamageEffects);

if (_medic isEqualTo objNull) then {
	[_patient, "ACE_splint"] call ACEFUNC(common,addToInventory);
} else {
	[_medic, "ACE_splint"] call ACEFUNC(common,addToInventory);
};