#include "..\script_component.hpp"
/*
 * Author: Blue
 * Get time required to stitch wrapped wounds
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * Time to wrap <INT>
 *
 * Example:
 * [player, cursorTarget] call kat_damage_fnc_getStitchWrapTime;
 *
 * Public: No
 */

params ["_medic", "_patient"];

count (GET_WRAPPED_WOUNDS(_patient) getOrDefault [_bodyPart, []]) * 2;