#include "..\script_component.hpp"
/*
 * Author: PabstMirror
 * Modified: Blue
 * Local callback for applying a splint to a patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_splintLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];
TRACE_3("splintLocal",_medic,_patient,_bodyPart);

private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;

private _fractures = GET_FRACTURES(_patient);
_fractures set [_partIndex, -1];
_patient setVariable [VAR_FRACTURES, _fractures, true];

if (ACEGVAR(medical,fractures) > 1) then {
    private _splints = GET_SPLINTS(_patient);
    _splints set [_partIndex, 1];
    _patient setVariable [VAR_SPLINTS, _splints, true];
};

// Check if we fixed limping from this treatment
[_patient] call ACEFUNC(medical_engine,updateDamageEffects);

[_patient, "ACE_splint"] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_appliedSplint), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
