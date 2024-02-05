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
        [["rhs_weap_mk18_d","rhsusf_acc_nt4_tan","acc_flashlight","rhsusf_acc_eotech_552_d",["rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan_Tracer_Red",30],[],"rhsusf_acc_rvg_de"],[],[],["rhs_uniform_FROG01_wd",[["FirstAidKit",5]]],["rhsusf_spc_corpsman",[["FirstAidKit",2],["rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan_Tracer_Red",11,30]]],["rhsusf_falconii_coy",[["FirstAidKit",2],["Chemlight_yellow",2,1],["HandGrenade",3,1],["Chemlight_red",2,1],["B_IR_Grenade",2,1]]],"rhsusf_mich_helmet_marpatwd_headset","rhs_googles_black",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","","rhsusf_ANPVS_14"]]
    ]
};
[]
