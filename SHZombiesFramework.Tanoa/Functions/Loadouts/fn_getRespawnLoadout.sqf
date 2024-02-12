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
        [["arifle_MX_SW_khk_F","muzzle_snds_H_khk_F","acc_flashlight","optic_Holosight_smg_khk_F",["100Rnd_65x39_caseless_khaki_mag",100],[],"bipod_01_F_khk"],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_B_T_Soldier_F",[["FirstAidKit",5]]],["V_PlateCarrier1_tna_F",[["100Rnd_65x39_caseless_khaki_mag",3,100],["11Rnd_45ACP_Mag",3,11],["HandGrenade",4,1],["Chemlight_blue",2,1]]],["B_AssaultPack_tna_F",[["FirstAidKit",3],["100Rnd_65x39_caseless_khaki_mag",2,100]]],"H_HelmetB_Light_tna_F","G_Lowprofile",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]
    ]
};
[]
