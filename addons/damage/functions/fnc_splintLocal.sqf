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
 * 3: Action Classname <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call ace_medical_treatment_fnc_splintLocal;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname"];
TRACE_3("splintLocal",_medic,_patient,_bodyPart);
systemchat format ["%1",_this];
private _partIndex = ALL_BODY_PARTS find toLower _bodyPart;

private _fractures = GET_FRACTURES(_patient);
_fractures set [_partIndex, -1];
_patient setVariable [VAR_FRACTURES, _fractures, true];

private _item = "ACE_splint";

if (_classname isEqualTo "ApplySAMSplint" && ACEGVAR(medical,fractures) > 1) then {
    private _splints = GET_SPLINTS(_patient);
    _splints set [_partIndex, 1];
    _patient setVariable [VAR_SPLINTS, _splints, true];

    _item = "KAT_SAMSplint";

    // Splint falls off after a while
    [{
        params ["_patient", "_bodyPart"];

        GET_SPLINTS(_patient) select (ALL_BODY_PARTS find toLower _bodyPart) != 1;
    }, {}, [_patient, _bodyPart], (random [60, 90, 120]), {
        params ["_patient", "_bodyPart"];

        [objNull, _patient, _bodyPart] call FUNC(removeSplintLocal);
        ["Splint has fallen off", 1.5, _patient] call ACEFUNC(common,displayTextStructured);
    }] call CBA_fnc_waitUntilAndExecute;
};

// Check if we fixed limping from this treatment
[_patient] call ACEFUNC(medical_engine,updateDamageEffects);

[_patient, _item] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", ACELSTRING(medical_treatment,Activity_appliedSplint), [[_medic, false, true] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);