/*
Function: SHZ_fnc_lookupShopkeeperCatalog

Description:
    Returns the stats for an item, or an index of all items.

Parameters:
    String itemID:
        (Optional, default "")
        The item ID to look up, or an empty string to return all available items.

Returns:
    HashMap:
        If item was an empty string, returns a hashmap of hashmaps for
        each available item.
        If the item ID is valid, returns its hashmap.
        If item was an invalid string, returns an empty hashmap.

Author:
    thegamecracks

*/
params [["_itemID", ""]];

private _getVehicleName = {
    params ["_cls"];
    getText (configFile >> "CfgVehicles" >> _cls >> "displayName")
};
private _getWeaponName = {
    params ["_cls"];
    getText (configFile >> "CfgWeapons" >> _cls >> "displayName")
};

private _index = localNamespace getVariable "SHZ_shopkeeper_catalog";
if (isNil "_index") then {
    _index = compileFinal createHashMapFromArray [
        ["apc_bradley", createHashMapFromArray [
            ["_displayName", "M2 Bradley"],
            ["_vehicleType", {selectRandom [
                "RHS_M2A3_wd",
                "RHS_M2A3_BUSKI_wd",
                "RHS_M2A3_BUSKIII_wd"
            ]}],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "apc"],
            ["_cost", 15000]
        ]],
        ["apc_stryker_m2", createHashMapFromArray [
            ["_displayName", "M1126 Stryker (CROWS/M2)"],
            ["_vehicleType", "rhsusf_stryker_m1126_m2_wd"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "apc"],
            ["_cost", 5000]
        ]],
        ["cargo_fuel", createHashMapFromArray [
            ["_displayName", "FlexibleTank_01_forest_F" call _getVehicleName],
            ["_cargoType", "FlexibleTank_01_forest_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 1500]
        ]],
        ["cargo_explosives", createHashMapFromArray [
            ["_displayName", "Box_NATO_AmmoOrd_F" call _getVehicleName],
            ["_cargoType", "Box_NATO_AmmoOrd_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 300]
        ]],
        ["cargo_grenades", createHashMapFromArray [
            ["_displayName", "Box_NATO_Grenades_F" call _getVehicleName],
            ["_cargoType", "Box_NATO_Grenades_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 300]
        ]],
        ["cargo_huron_ammo", createHashMapFromArray [
            ["_displayName", "B_Slingload_01_Ammo_F" call _getVehicleName],
            ["_cargoType", "B_Slingload_01_Ammo_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 1000]
        ]],
        ["cargo_huron_fuel", createHashMapFromArray [
            ["_displayName", "B_Slingload_01_Fuel_F" call _getVehicleName],
            ["_cargoType", "B_Slingload_01_Fuel_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 1000]
        ]],
        ["cargo_huron_medical", createHashMapFromArray [
            ["_displayName", "B_Slingload_01_Medevac_F" call _getVehicleName],
            ["_cargoType", "B_Slingload_01_Medevac_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 1000]
        ]],
        ["cargo_huron_repair", createHashMapFromArray [
            ["_displayName", "B_Slingload_01_Repair_F" call _getVehicleName],
            ["_cargoType", "B_Slingload_01_Repair_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 1000]
        ]],
        ["cargo_rhsusf_equipment", createHashMapFromArray [
            ["_displayName", "rhsusf_gear_crate" call _getVehicleName],
            ["_cargoType", "rhsusf_gear_crate"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 2000]
        ]],
        ["cargo_rhsusf_launchers", createHashMapFromArray [
            ["_displayName", "rhsusf_launcher_crate" call _getVehicleName],
            ["_cargoType", "rhsusf_launcher_crate"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 2000]
        ]],
        ["cargo_rhsusf_weapons", createHashMapFromArray [
            ["_displayName", "rhsusf_weapon_crate" call _getVehicleName],
            ["_cargoType", "rhsusf_weapon_crate"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 2000]
        ]],
        ["cargo_vehicle_ammo", createHashMapFromArray [
            ["_displayName", "Box_NATO_AmmoVeh_F" call _getVehicleName],
            ["_cargoType", "Box_NATO_AmmoVeh_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 2000]
        ]],
        ["car_quadbike", createHashMapFromArray [
            ["_displayName", "Quadbike"],
            ["_vehicleType", "B_T_Quadbike_01_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "car"],
            ["_cost", 1000]
        ]],
        ["cas_heli_ah64d", createHashMapFromArray [
            ["_displayName", "RHS_AH64D_wd" call _getVehicleName],
            ["_vehicleType", "RHS_AH64D_wd"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", [
                "rhs_mag_ATAS_AH64_2",
                "rhs_mag_M151_19",
                "rhs_mag_M151_19",
                "rhs_mag_M151_19",
                "rhs_mag_M151_19",
                "rhs_mag_ATAS_AH64_2",
                "rhsusf_M130_CMFlare_Chaff_Magazine_x2"
            ]],
            ["_vehicleRandomDir", true],
            ["_category", "cas_heli"],
            ["_cost", 20000]
        ]],
        ["cas_heli_blackfoot", createHashMapFromArray [
            ["_displayName", "B_Heli_Attack_01_dynamicLoadout_F" call _getVehicleName],
            ["_vehicleType", "B_Heli_Attack_01_dynamicLoadout_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", [
                ["PylonRack_12Rnd_missiles",       false, [-1]],
                ["PylonMissile_1Rnd_AAA_missiles", false, [ 0]],
                ["PylonRack_12Rnd_PG_missiles",    false, [ 0]],
                ["PylonRack_12Rnd_PG_missiles",    false, [ 0]],
                ["PylonMissile_1Rnd_AAA_missiles", false, [ 0]],
                ["PylonRack_12Rnd_missiles",       false, [-1]]
            ]],
            ["_vehicleRandomDir", true],
            ["_category", "cas_heli"],
            ["_cost", 20000]
        ]],
        ["cas_heli_huey_armed", createHashMapFromArray [
            ["_displayName", "UH-1Y Venom (Armed)"],
            ["_vehicleType", "RHS_UH1Y"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "cas_heli"],
            ["_cost", 10000]
        ]],
        ["cas_heli_littlebird_armed", createHashMapFromArray [
            ["_displayName", "RHS_MELB_AH6M" call _getVehicleName],
            ["_vehicleType", "RHS_MELB_AH6M"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "cas_heli"],
            ["_cost", 10000]
        ]],
        ["cas_plane_blackfish_armed", createHashMapFromArray [
            ["_displayName", "B_T_VTOL_01_armed_F" call _getVehicleName],
            ["_vehicleType", "B_T_VTOL_01_armed_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", false],
            ["_category", "cas_plane"],
            ["_cost", 30000]
        ]],
        ["cas_plane_gryphon", createHashMapFromArray [
            ["_displayName", "I_Plane_Fighter_04_F" call _getVehicleName],
            ["_vehicleType", "I_Plane_Fighter_04_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_category", "cas_plane"],
            ["_vehicleLock", true],
            ["_vehiclePylons", [
                "PylonMissile_Missile_BIM9X_x1",
                "PylonMissile_Missile_BIM9X_x1",
                "PylonRack_Missile_AGM_02_x1",
                "PylonRack_Missile_AGM_02_x1",
                "PylonMissile_Bomb_GBU12_x1",
                "PylonMissile_Bomb_GBU12_x1"
            ]],
            ["_vehicleRandomDir", false],
            ["_cost", 25000]
        ]],
        ["heli_blackhawk", createHashMapFromArray [
            ["_displayName", "UH-60 Black Hawk"],
            ["_vehicleType", "RHS_UH60M"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "heli"],
            ["_cost", 2000]
        ]],
        ["heli_chinook", createHashMapFromArray [
            ["_displayName", "CH-47F Chinook"],
            ["_vehicleType", "RHS_CH_47F_10"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "heli"],
            ["_cost", 7000]
        ]],
        ["heli_littlebird", createHashMapFromArray [
            ["_displayName", "RHS_MELB_MH6M" call _getVehicleName],
            ["_vehicleType", "RHS_MELB_MH6M"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "heli"],
            ["_cost", 2000]
        ]],
        ["heli_super_stallion_gau21", createHashMapFromArray [
            ["_displayName", "CH-53E Super Stallion (GAU-21)"],
            ["_vehicleType", "rhsusf_CH53E_USMC_GAU21"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "heli"],
            ["_cost", 12000]
        ]],
        ["medical_pills", createHashMapFromArray [
            ["_displayName", "RyanZombiesAntiVirusTemporary_Item" call _getWeaponName],
            ["_functionName", "SHZ_fnc_buyPills"],
            ["_category", "medical"],
            ["_cost", 150]
        ]],
        ["mrap_matv", createHashMapFromArray [
            ["_displayName", "Oshkosh M-ATV (CROWS/M2)"],
            ["_vehicleType", "rhsusf_m1240a1_m2crows_usmc_wd"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "mrap"],
            ["_cost", 5000]
        ]],
        ["plane_hercules_cargo", createHashMapFromArray [
            ["_displayName", "RHS_C130J_Cargo" call _getVehicleName],
            ["_vehicleType", "RHS_C130J_Cargo"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", false],
            ["_category", "plane"],
            ["_cost", 15000]
        ]],
        ["recruit_autorifleman_m249", createHashMapFromArray [
            ["_displayName", "rhsusf_usmc_marpat_wd_autorifleman_m249" call _getVehicleName],
            ["_recruitType", "rhsusf_usmc_marpat_wd_autorifleman_m249"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["recruit_autorifleman_m27", createHashMapFromArray [
            ["_displayName", "rhsusf_usmc_marpat_wd_autorifleman" call _getVehicleName],
            ["_recruitType", "rhsusf_usmc_marpat_wd_autorifleman"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["recruit_engineer", createHashMapFromArray [
            ["_displayName", "rhsusf_usmc_marpat_wd_engineer" call _getVehicleName],
            ["_recruitType", "rhsusf_usmc_marpat_wd_engineer"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 200]
        ]],
        ["recruit_grenadier", createHashMapFromArray [
            ["_displayName", "rhsusf_usmc_marpat_wd_grenadier" call _getVehicleName],
            ["_recruitType", "rhsusf_usmc_marpat_wd_grenadier"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 200]
        ]],
        ["recruit_marksman", createHashMapFromArray [
            ["_displayName", "rhsusf_usmc_marpat_wd_marksman" call _getVehicleName],
            ["_recruitType", "rhsusf_usmc_marpat_wd_marksman"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["recruit_medic", createHashMapFromArray [
            ["_displayName", "rhsusf_navy_marpat_wd_medic" call _getVehicleName],
            ["_recruitType", "rhsusf_navy_marpat_wd_medic"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 200]
        ]],
        ["recruit_rifleman", createHashMapFromArray [
            ["_displayName", "rhsusf_usmc_marpat_wd_rifleman_m4" call _getVehicleName],
            ["_recruitType", "rhsusf_usmc_marpat_wd_rifleman_m4"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 100]
        ]],
        ["recruit_shotgun", createHashMapFromArray [
            ["_displayName", "rhsusf_usmc_marpat_wd_rifleman_m590" call _getVehicleName],
            ["_recruitType", "rhsusf_usmc_marpat_wd_rifleman_m590"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["recruit_sniper", createHashMapFromArray [
            ["_displayName", "rhsusf_usmc_marpat_wd_sniper" call _getVehicleName],
            ["_recruitType", "rhsusf_usmc_marpat_wd_sniper"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["tank_abrams", createHashMapFromArray [
            ["_displayName", "M1 Abrams"],
            ["_vehicleType", {selectRandom [
                "rhsusf_m1a1aimwd_usarmy",
                "rhsusf_m1a1aim_tuski_wd",
                "rhsusf_m1a2sep1wd_usarmy",
                "rhsusf_m1a2sep1tuskiwd_usarmy",
                "rhsusf_m1a2sep1tuskiiwd_usarmy",
                "rhsusf_m1a2sep2wd_usarmy"
            ]}],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "tank"],
            ["_cost", 10000]
        ]],
        ["uav_sentinel", createHashMapFromArray [
            ["_displayName", "B_UAV_05_F" call _getVehicleName],
            ["_vehicleType", "B_UAV_05_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", false],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", false],
            ["_category", "uav"],
            ["_cost", 10000]
        ]],
        ["ugv_stomper_rcws", createHashMapFromArray [
            ["_displayName", "B_T_UGV_01_rcws_olive_F" call _getVehicleName],
            ["_vehicleType", "B_T_UGV_01_rcws_olive_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", false],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "ugv"],
            ["_cost", 5000]
        ]]
    ];
    localNamespace setVariable ["SHZ_shopkeeper_catalog", _index];
};

if (_itemID isEqualTo "") exitWith {_index};
_index get _itemID
