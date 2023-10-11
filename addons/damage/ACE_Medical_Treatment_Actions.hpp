class ACE_Medical_Treatment_Actions {
    class BasicBandage;
    class Splint;
    class Morphine;
    class SurgicalKit;

    class PressureBandage: BasicBandage {
        displayName = "Pressure Bandage";
        displayNameProgress = ACECSTRING(medical_treatment,Bandaging);
        icon = QACEPATHTOF(medical_treatment,ui\bandage.paa);
        category = "bandage";

        consumeItem = 1;
        items[] = {"KAT_pressureBandage"};

        medicRequired = 0;
        allowSelfTreatment = 1;
        allowedSelections[] = {"All"};
        treatmentLocations = TREATMENT_LOCATIONS_ALL;

        treatmentTime = QFUNC(getBandageTime);

        callbackStart = "";
        callbackProgress = "";
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        callbackFailure = "";

        animationMedic = "AinvPknlMstpSlayW[wpn]Dnon_medicOther";
        animationMedicProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
        animationMedicSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
        animationMedicSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
    };
    class EmergencyTraumaDressing: PressureBandage {
        displayName = "Emergency Trauma Dressing";
        items[] = {"KAT_emergencyTraumaDressing"};
        allowSelfTreatment = 0;
    };
    class ElasticWrap: PressureBandage {
        displayName = "Wrap Bruises";
        displayNameProgress = "Wrapping...";
        items[] = {"KAT_elasticWrap"};
        medicRequired = 1;
        condition = QUOTE([ARR_4(_medic, _patient, _bodyPart, 2)] call FUNC(canWrap));
        treatmentTime = QFUNC(getBruiseWrapTime);
        callbackSuccess = QFUNC(wrapBruises);
    };
    class ElasticWrapBandages: ElasticWrap {
        displayName = "Wrap Bandaged Wounds";
        condition = QUOTE([ARR_3(_medic, _patient, _bodyPart)] call FUNC(canWrap));
        treatmentTime = QUOTE([ARR_4(_medic, _patient, _bodyPart, 0)] call FUNC(getWrapTime));
        callbackSuccess = QUOTE([ARR_4(_medic, _patient, _bodyPart, 0)] call FUNC(wrapBodypart));
    };
    class ElasticWrapClots: ElasticWrap {
        displayName = "Wrap Clotted Wounds";
        condition = QUOTE([ARR_4(_medic, _patient, _bodyPart, 1)] call FUNC(canWrap));
        treatmentTime = QUOTE([ARR_4(_medic, _patient, _bodyPart, 1)] call FUNC(getWrapTime));
        callbackSuccess = QUOTE([ARR_4(_medic, _patient, _bodyPart, 1)] call FUNC(wrapBodypart));
    };
    class ElasticWrapSplint: ElasticWrap {
        displayName = "Wrap SAM Splint";
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        condition = QFUNC(canWrapSplint);
        treatmentTime = QFUNC(getSplintWrapTime);
        callbackSuccess = QFUNC(wrapSplint);
    };
    class ApplySAMSplint: Splint {
        displayName = "Apply SAM Splint";
        items[] = {"KAT_SAMSplint"};
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        condition = QACEFUNC(medical_treatment,canSplint);
        treatmentTime = 3;
        callbackSuccess = QFUNC(splint);
    };
    class RemoveSAMSplint: Splint {
        displayName = "Remove SAM Splint";
        displayNameProgress = "Removing SAM Splint";
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        items[] = {};
        condition = QFUNC(canRemoveSplint);
        treatmentTime = 3;
        callbackSuccess = QFUNC(removeSplint);
        litter[] = {};
    };
    class ChitosanInjector: Morphine {
        displayName = "Use Chitosan Injector";
        displayNameProgress = "Using Chitosan Injector";
        icon = QACEPATHTOF(medical_gui,ui\auto_injector.paa);
        category = "bandage";
        allowedSelections[] = {"All"};
        items[] = {"KAT_chitosanInjector"};
        condition = QUOTE([ARR_2(_patient, _bodyPart)] call FUNC(isBodyPartBleeding));
        callbackSuccess = QFUNC(applyChitosanInjector);
        litter[] = {};
    };
    class StitchWrappedWounds: SurgicalKit {
        displayName = "Use Surgical Kit (Wrapped)";
        treatmentTime = QUOTE([ARR_3(_patient, _bodyPart, 1)] call FUNC(getStitchTime));
        condition = QUOTE([ARR_3(_medic, _patient, _bodyPart)] call FUNC(canStitch));
        callbackProgress = QUOTE([ARR_4(_args, _elapsedTime, _totalTime, 1)] call FUNC(surgicalKitProgress));
    };
    class StitchClottedWounds: SurgicalKit {
        displayName = "Use Surgical Kit (Clotted)";
        treatmentTime = QUOTE([ARR_3(_patient, _bodyPart, 2)] call FUNC(getStitchTime));
        condition = QUOTE([ARR_4(_medic, _patient, _bodyPart, 1)] call FUNC(canStitch));
        callbackProgress = QUOTE([ARR_4(_args, _elapsedTime, _totalTime, 2)] call FUNC(surgicalKitProgress));
    };
};
