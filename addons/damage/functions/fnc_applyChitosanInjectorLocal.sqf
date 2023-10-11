#include "..\script_component.hpp"
/*
 * Author: Blue
 * Use Chitosan Injector on body part
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, "body"] call kat_damage_fnc_applyChitosanInjectorLocal;
 *
 * Public: No
 */

params ["_patient", "_bodyPart"];

private _openWoundsOnPart = GET_OPEN_WOUNDS(_patient) getOrDefault [_bodyPart, [], true];

if (_openWoundsOnPart isEqualTo []) exitWith {};

private _injectedTime = CBA_missionTime;

[{
    params ["_patient", "_bodyPart", "_injectedTime"];

    [{
        params ["_args", "_idPFH"];
        _args params ["_patient", "_bodyPart", "_injectedTime"];

        if (!(alive _patient) || (_injectedTime + 60) < CBA_missionTime) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };

        if ([_patient, _bodyPart] call FUNC(isBodyPartBleeding)) then {
            [_patient, _bodyPart] call FUNC(clotWoundsOnBodyPart);

            if (_bodyPart isEqualTo "head") then {
                [_patient, (GET_PAIN(_patient) + 0.05)] call ACEFUNC(medical_status,adjustPainLevel);
            } else {
                [_patient, (GET_PAIN(_patient) + 0.02)] call ACEFUNC(medical_status,adjustPainLevel);
            };
        };
    }, 1, [_patient, _bodyPart, _injectedTime]] call CBA_fnc_addPerFrameHandler;
}, [_patient, _bodyPart, _injectedTime], 4] call CBA_fnc_waitAndExecute;