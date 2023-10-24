#include "script_component.hpp"

[QGVAR(wrapBruisesLocal), LINKFUNC(wrapBruisesLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removeSplintLocal), LINKFUNC(removeSplintLocal)] call CBA_fnc_addEventHandler;
[QGVAR(applyChitosanInjectorLocal), LINKFUNC(applyChitosanInjectorLocal)] call CBA_fnc_addEventHandler;
[QGVAR(handleCoagulationPFH), LINKFUNC(handleCoagulationPFH)] call CBA_fnc_addEventHandler;