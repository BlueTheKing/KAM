#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {};
        weapons[] = {};
        magazines[] = { };
        requiredAddons[] = {
            "kat_main",
            "ace_zeus",
            "cba_settings"
        };
        author = "Blue";
        authors[] = {"Blue"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

//#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"
#include "CfgWeapons.hpp"
#include "CfgEventHandlers.hpp"
#include "ACE_Medical_Treatment.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"