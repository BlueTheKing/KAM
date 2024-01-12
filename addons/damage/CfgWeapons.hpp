class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class KAT_pressureBandage: ACE_ItemCore {
        scope = 2;
        author = "Blue";
        model = QACEPATHTOF(medical_treatment,data\bandage.p3d);
        picture = QPATHTOF(ui\pressurebandage.paa);
        displayName = CSTRING(PressureBandage_Display);
        descriptionShort = CSTRING(PressureBandage_Desc_Short);
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
        displayName = CSTRING(EmergencyTraumaDressing_Display);
        descriptionShort = CSTRING(EmergencyTraumaDressing_Desc_Short);
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
        displayName = CSTRING(ElasticWrap_Display);
        descriptionShort = CSTRING(ElasticWrap_Desc_Short);
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
        displayName = CSTRING(ChitosanInjector_Display);
        descriptionShort = CSTRING(ChitosanInjector_Desc_Short);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class ACE_splint;
    class KAT_UniversalSplint: ACE_splint {
        author = "Blue";
        picture = QPATHTOF(ui\samSplint.paa);
        displayName = CSTRING(SAMSplint_Display);
        descriptionShort = CSTRING(SAMSplint_Desc_Short);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
};
