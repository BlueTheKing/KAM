#include "..\script_component.hpp"
/*
 * Author: PabstMirror
 * Modified: Blue
 * Applies a splint to the patient on the given body part.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Classname <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, cursorObject, "LeftLeg", "ApplySAMSplint"] call ace_medical_treatment_fnc_splint;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", "_classname"];
TRACE_3("splint",_medic,_patient,_bodyPart);

[QACEGVAR(medical_treatment,splintLocal), [_medic, _patient, _bodyPart, _classname], _patient] call CBA_fnc_targetEvent;