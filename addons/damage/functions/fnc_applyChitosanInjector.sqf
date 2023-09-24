#include "script_component.hpp"
/*
 * Author: Blue
 * Use Chitosan Injector on body part (treatment)
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
 * [player, cursorTarget, "body"] call kat_damage_fnc_applyChitosanInjector;
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

[QGVAR(applyChitosanInjectorLocal), [_patient, _bodyPart], _patient] call CBA_fnc_targetEvent;

[_patient, "KAT_chitosanInjector"] call ACEFUNC(medical_treatment,addToTriageCard);
[_patient, "activity", "%1 used %2 on %3", [[_medic] call ACEFUNC(common,getName), "Chitosan Injector", _bodyPart]] call ACEFUNC(medical_treatment,addToLog);