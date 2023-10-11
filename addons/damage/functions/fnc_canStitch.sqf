#include "..\script_component.hpp"
/*
 * Author: Katalam, mharis001, Brett Mayson
 * Modified: Blue
 * Checks if the patient's body part can be stitched.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 * 3: Wound Type <INT>
 *
 * ReturnValue:
 * Can Stitch <BOOL>
 *
 * Example:
 * [player, cursorTarget, "head", 0] call kat_damage_fnc_canStitch;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart", ["_type", 0]];

if ((ACEGVAR(medical_treatment,consumeSurgicalKit) == 2) && {!([_medic, _patient, ["ACE_suture"]] call ACEFUNC(medical_treatment,hasItem))}) exitWith {false};

(!([_patient, _bodyPart] call FUNC(isBodyPartBleeding)) && {
    if (_type == 1) then {
        (GET_CLOTTED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo []
    } else {
        (GET_WRAPPED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) isNotEqualTo []
    };
})