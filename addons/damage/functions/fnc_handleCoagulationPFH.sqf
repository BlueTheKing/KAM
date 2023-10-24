#include "..\script_component.hpp"
/*
 * Author: Blue
 * Handle coagulation
 *
 * Arguments:
 * 0: Target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call kat_damage_fnc_handleCoagulationPFH;
 *
 * Public: No
 */

params ["_unit"];

if (!(EGVAR(pharma,coagulation)) || _unit getVariable [QEGVAR(pharma,coagulationPFH), -1] != -1 || !(IS_BLEEDING(_unit))) exitWith {};

private _id = [{
    params ["_args", "_idPFH"];
    _args params ["_unit"];

    if !(alive _unit) exitWith {
        _unit setVariable [QEGVAR(pharma,coagulationPFH), -1];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    
    private _exit = true;
    private _factors = _unit getVariable [QEGVAR(pharma,coagulationFactor), 10];

    if (GET_HEART_RATE(_unit) < 30) exitWith {};
    if (_factors < 1) exitWith {};

    private _txaCount = [_unit, "TXA"] call ACEFUNC(medical_status,getMedicationCount);

    {
        _x params ["_targetBodyPart"];
        
        private _openWounds = GET_OPEN_WOUNDS(_unit);
        private _openWoundsOnPart = _openWounds getOrDefault [_targetBodyPart, []];

        if (_openWoundsOnPart isEqualTo [] || [_unit, _x] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo)) then {
            continue;
        };

        private _woundIndex = _openWoundsOnPart findIf {(_x select 1) > 0 && (_x select 2) > 0};
        
        if (_woundIndex != -1) exitWith {
            [_unit, _targetBodyPart, 6] call FUNC(clotWoundsOnBodyPart);
            _exit = false;
            _unit setVariable [QEGVAR(pharma,coagulationFactor), (_factors - 1), true];
        };
    } forEach ALL_BODY_PARTS_PRIORITY;

    if (!(alive _unit) || _exit) exitWith {
        _unit setVariable [QEGVAR(pharma,coagulationPFH), -1];
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
}, 8, [_unit]] call CBA_fnc_addPerFrameHandler;

_unit setVariable [QEGVAR(pharma,coagulationPFH), _id];