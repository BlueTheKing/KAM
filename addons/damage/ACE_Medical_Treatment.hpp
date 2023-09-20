class ACE_ADDON(Medical_Treatment) {
    class Bandaging {
        class FieldDressing;

        class PressureBandage: FieldDressing {
            reopeningChance = 0.1;
            reopeningMinDelay = 120;
            reopeningMaxDelay = 200;

            class Abrasion {
                effectiveness = 3;
                reopeningChance = 0.6;
                reopeningMinDelay = 800;
                reopeningMaxDelay = 1500;
            };
            class AbrasionMinor: Abrasion {
                effectiveness = 3;
            };
            class AbrasionMedium: Abrasion {
                effectiveness = 2.5;
                reopeningChance = 0.9;
            };
            class AbrasionLarge: Abrasion {
                effectiveness = 2;
                reopeningChance = 1;
            };

            class Avulsion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.7;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 1600;
            };
            class AvulsionMinor: Avulsion {
                effectiveness = 1;
            };
            class AvulsionMedium: Avulsion {
                effectiveness = 0.9;
            };
            class AvulsionLarge: Avulsion {
                effectiveness = 0.75;
            };

            class Contusion: Abrasion {
                effectiveness = 1;
                reopeningChance = 0;
                reopeningMinDelay = 0;
                reopeningMaxDelay = 0;
            };
            class ContusionMinor: Contusion {};
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {};

            class Crush: Abrasion {
                effectiveness = 1;
                reopeningChance = 0.5;
                reopeningMinDelay = 600;
                reopeningMaxDelay = 1000;
            };
            class CrushMinor: Crush {
                effectiveness = 1;
                reopeningChance = 0.6;
            };
            class CrushMedium: Crush {
                effectiveness = 0.7;
                reopeningChance = 0.7;
            };
            class CrushLarge: Crush {
                effectiveness = 0.6;
                reopeningChance = 0.8;
            };

            class Cut: Abrasion {
                effectiveness = 4;
                reopeningChance = 0.4;
                reopeningMinDelay = 700;
                reopeningMaxDelay = 1000;
            };
            class CutMinor: Cut {
                effectiveness = 4;
                reopeningChance = 0.6;
            };
            class CutMedium: Cut {
                effectiveness = 3;
                reopeningChance = 0.7;
            };
            class CutLarge: Cut {
                effectiveness = 1;
                reopeningChance = 0.8;
            };

            class Laceration: Abrasion {
                effectiveness = 0.95;
                reopeningChance = 0.65;
                reopeningMinDelay = 500;
                reopeningMaxDelay = 2000;
            };
            class LacerationMinor: Laceration {
                effectiveness = 0.95;
                reopeningChance = 0.65;
            };
            class LacerationMedium: Laceration {
                effectiveness = 0.7;
                reopeningChance = 0.8;
            };
            class LacerationLarge: Laceration {
                effectiveness = 0.5;
                reopeningChance = 0.9;
            };

            class VelocityWound: Abrasion {
                effectiveness = 2;
                reopeningChance = 1;
                reopeningMinDelay = 800;
                reopeningMaxDelay = 2000;
            };
            class VelocityWoundMinor: VelocityWound {
                effectiveness = 2;
            };
            class VelocityWoundMedium: VelocityWound {
                effectiveness = 1.5;
            };
            class VelocityWoundLarge: VelocityWound {
                effectiveness = 1;
            };

            class PunctureWound: Abrasion {
                effectiveness = 2;
                reopeningChance = 1;
                reopeningMinDelay = 1000;
                reopeningMaxDelay = 3000;
            };
            class PunctureWoundMinor: PunctureWound {
                effectiveness = 2;
            };
            class PunctureWoundMedium: PunctureWound {
                effectiveness = 1.3;
            };
            class PunctureWoundLarge: PunctureWound {
                effectiveness = 0.9;
            };
        };

        class EmergencyTraumaDressing: PressureBandage {};
        class ElasticWrap: PressureBandage {
            reopeningChance = 0;

            class Abrasion {
                effectiveness = 0;
            };
            class AbrasionMinor: Abrasion {};
            class AbrasionMedium: Abrasion {};
            class AbrasionLarge: Abrasion {};

            class Avulsion: Abrasion {};
            class AvulsionMinor: Avulsion {};
            class AvulsionMedium: Avulsion {};
            class AvulsionLarge: Avulsion {};

            class Contusion {
                effectiveness = 2;
                reopeningChance = 0;
                reopeningMinDelay = 0;
                reopeningMaxDelay = 0;
            };
            class ContusionMinor: Contusion {
                effectiveness = 3;
            };
            class ContusionMedium: Contusion {};
            class ContusionLarge: Contusion {
                effectiveness = 1;
            };

            class Crush: Abrasion {};
            class CrushMinor: Crush {};
            class CrushMedium: Crush {};
            class CrushLarge: Crush {};

            class Cut: Abrasion {};
            class CutMinor: Cut {};
            class CutMedium: Cut {};
            class CutLarge: Cut {};

            class Laceration: Abrasion {};
            class LacerationMinor: Laceration {};
            class LacerationMedium: Laceration {};
            class LacerationLarge: Laceration { };

            class VelocityWound: Abrasion {};
            class VelocityWoundMinor: VelocityWound {};
            class VelocityWoundMedium: VelocityWound {};
            class VelocityWoundLarge: VelocityWound {};

            class PunctureWound: Abrasion {};
            class PunctureWoundMinor: PunctureWound {};
            class PunctureWoundMedium: PunctureWound {};
            class PunctureWoundLarge: PunctureWound {};
        };
    };
};
