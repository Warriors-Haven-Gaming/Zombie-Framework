/*
Function: SHZ_fnc_getRespawnLoadout

Description:
    Returns the loadout for the given unit to respawn with.

Parameters:
    Object unit:
        The unit to retrieve the loadout for.

Returns:
    Array
        The loadout to be used with setUnitLoadout, or an empty array
        if not available.

Examples:
    (begin example)
        [player] call SHZ_fnc_getRespawnLoadout;
    (end)

Author:
    thegamecracks

*/
params ["_unit"];
if (side _unit isEqualTo blufor) exitWith {
    selectRandom [
        [["rhs_weap_m4_carryhandle_m203","","acc_flashlight","rhsusf_acc_ACOG2_USMC",["rhs_mag_30Rnd_556x45_M855_Stanag",30],["rhs_mag_M433_HEDP",1],""],[],["rhsusf_weap_glock17g4","","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_FROG01_wd",[["FirstAidKit",1],["rhsusf_ANPVS_14",1],["rhsusf_mag_17Rnd_9x19_JHP",2,17]]],["rhsusf_spc_teamleader",[["rhs_mag_30Rnd_556x45_M855_Stanag",8,30],["rhs_mag_M433_HEDP",5,1],["rhs_mag_m67",2,1],["rhs_mag_m18_yellow",1,1],["rhs_mag_m18_purple",1,1],["rhsusf_mag_17Rnd_9x19_JHP",3,17]]],["rhsusf_falconii_coy_gr",[["rhs_mag_M433_HEDP",10,1],["rhs_mag_M583A1_white",5,1]]],"rhsusf_lwh_helmet_marpatwd_ess","rhs_googles_clear",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
        [["rhs_weap_m27iar_grip","","acc_flashlight","rhsusf_acc_ACOG2_USMC",["rhs_mag_30Rnd_556x45_M855_Stanag",30],[],"rhsusf_acc_harris_bipod"],[],["rhsusf_weap_glock17g4","","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_FROG01_wd",[["FirstAidKit",1],["rhsusf_ANPVS_14",1],["rhsusf_mag_17Rnd_9x19_JHP",2,17]]],["rhsusf_spc_iar",[["rhs_mag_30Rnd_556x45_M855_Stanag",12,30],["rhs_mag_m67",2,1],["rhsusf_mag_17Rnd_9x19_JHP",5,17]]],["rhsusf_assault_eagleaiii_coy_m27",[["rhs_mag_30Rnd_556x45_M855_Stanag",10,30]]],"rhsusf_lwh_helmet_marpatwd_ess","rhs_googles_clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
        [["rhs_weap_m4_carryhandle","","acc_flashlight","rhsusf_acc_ACOG_USMC",["rhs_mag_30Rnd_556x45_M855_Stanag",30],[],"rhsusf_acc_kac_grip"],[],["rhsusf_weap_glock17g4","","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_FROG01_wd",[["FirstAidKit",1],["rhsusf_ANPVS_14",1],["rhs_mag_30Rnd_556x45_M855_Stanag",1,30]]],["rhsusf_spc_rifleman",[["rhs_mag_30Rnd_556x45_M855_Stanag",7,30],["rhs_mag_m67",2,1],["rhs_mag_an_m8hc",1,1],["rhsusf_mag_17Rnd_9x19_JHP",4,17]]],[],"rhsusf_lwh_helmet_marpatwd","rhs_googles_clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]],
        [["rhs_weap_m16a4_carryhandle","","acc_flashlight","rhsusf_acc_ACOG_USMC",["rhs_mag_30Rnd_556x45_M855_Stanag",30],[],""],["rhs_weap_M136","","","",["rhs_m136_mag",1],[],""],["rhsusf_weap_glock17g4","","acc_flashlight_pistol","",["rhsusf_mag_17Rnd_9x19_JHP",17],[],""],["rhs_uniform_FROG01_wd",[["FirstAidKit",1],["rhsusf_ANPVS_14",1],["rhsusf_mag_17Rnd_9x19_JHP",2,17]]],["rhsusf_spc_rifleman",[["rhs_mag_30Rnd_556x45_M855_Stanag",7,30],["rhs_mag_m67",2,1],["rhs_mag_an_m8hc",1,1],["rhsusf_mag_17Rnd_9x19_JHP",4,17]]],[],"rhsusf_lwh_helmet_marpatwd_ess","rhs_googles_clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]
    ]
};
[]
