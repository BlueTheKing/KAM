class CfgFunctions {
    class overwrite_medical_treatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class canBandage {
                file = QPATHTOF(functions\fnc_canBandage.sqf);
            };
            class splintLocal {
                file = QPATHTOF(functions\fnc_splintLocal.sqf);
            };
        };
    };
    class overwrite_medical_damage {
        tag = "ace_medical_damage";
        class ace_medical_damage {
            class woundsHandlerBase {
                file = QPATHTOF(functions\fnc_woundsHandlerBase.sqf);
            };
        };
    };
};
