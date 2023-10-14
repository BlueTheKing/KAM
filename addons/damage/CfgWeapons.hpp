class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class KAT_pressureBandage: ACE_ItemCore {
        scope = 2;
        author = "Blue";
        model = QACEPATHTOF(medical_treatment,data\bandage.p3d);
        picture = QPATHTOF(ui\pressurebandage.paa);
        displayName = "Pressure Bandage";//CSTRING(CombatGauze_Display);
        descriptionShort = "Standard issue bandage";//CSTRING(CombatGauze_Desc_Short);
        descriptionUse = "";//CSTRING(CombatGauze_Desc_Use);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class KAT_emergencyTraumaDressing: ACE_ItemCore {
        scope = 2;
        author = "Blue";
        model = QACEPATHTOF(medical_treatment,data\bandage.p3d);
        picture = QPATHTOF(ui\etd.paa);
        displayName = "Emergency Trauma Dressing";//CSTRING(CombatGauze_Display);
        descriptionShort = "Trauma dressing with large surface area";//CSTRING(CombatGauze_Desc_Short);
        descriptionUse = "";//CSTRING(CombatGauze_Desc_Use);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 3;
        };
    };
    class KAT_elasticWrap: ACE_ItemCore {
        scope = 2;
        author = "Blue";
        model = QACEPATHTOF(medical_treatment,data\bandage.p3d);
        picture = QACEPATHTOF(medical_treatment,ui\elasticbandage_ca.paa);
        displayName = "Elastic Wrap";//CSTRING(CombatGauze_Display);
        descriptionShort = "Used to wrap bandaged wounds";//CSTRING(CombatGauze_Desc_Short);
        descriptionUse = "";//CSTRING(CombatGauze_Desc_Use);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class KAT_chitosanInjector: ACE_ItemCore {
        scope = 2;
        author = "Blue";
        model = QACEPATHTOF(medical_treatment,data\bandage.p3d);
        picture = QPATHTOF(ui\chitosanInjector.paa);
        displayName = "Chitosan Granulate Injector";//CSTRING(CombatGauze_Display);
        descriptionShort = "";//CSTRING(CombatGauze_Desc_Short);
        descriptionUse = "";//CSTRING(CombatGauze_Desc_Use);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class ACE_splint;
    class KAT_SAMSplint: ACE_splint {
        author = "Blue";
        picture = QPATHTOF(ui\samsplint.paa);
        displayName = "SAM Splint";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};
