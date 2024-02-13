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
    [configFile >> "CfgVehicles" >> _cls] call BIS_fnc_displayName
};
private _getWeaponName = {
    params ["_cls"];
    [configFile >> "CfgWeapons" >> _cls] call BIS_fnc_displayName
};

private _index = localNamespace getVariable "SHZ_shopkeeper_catalog";
if (isNil "_index") then {
    _index = compileFinal createHashMapFromArray [
        ["apc_mora", createHashMapFromArray [
            ["_displayName", "I_APC_tracked_03_cannon_F" call _getVehicleName],
            ["_vehicleType", "I_APC_tracked_03_cannon_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "apc"],
            ["_cost", 15000]
        ]],
        ["apc_marshall", createHashMapFromArray [
            ["_displayName", "B_T_APC_Wheeled_01_cannon_F" call _getVehicleName],
            ["_vehicleType", "B_T_APC_Wheeled_01_cannon_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "apc"],
            ["_cost", 15000]
        ]],
        ["cargo_ammo", createHashMapFromArray [
            ["_displayName", "B_supplyCrate_F" call _getVehicleName],
            ["_cargoType", "B_supplyCrate_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 650]
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
        ["cargo_vehicle_ammo", createHashMapFromArray [
            ["_displayName", "Box_NATO_AmmoVeh_F" call _getVehicleName],
            ["_cargoType", "Box_NATO_AmmoVeh_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 2000]
        ]],
        ["cargo_weapons", createHashMapFromArray [
            ["_displayName", "Box_T_NATO_Wps_F" call _getVehicleName],
            ["_cargoType", "Box_T_NATO_Wps_F"],
            ["_functionName", "SHZ_fnc_buyCargoBox"],
            ["_category", "cargo"],
            ["_cost", 300]
        ]],
        ["car_prowler_light", createHashMapFromArray [
            ["_displayName", "B_CTRG_LSV_01_light_F" call _getVehicleName],
            ["_vehicleType", "B_CTRG_LSV_01_light_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "car"],
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
        ["cas_heli_kajman", createHashMapFromArray [
            ["_displayName", "O_Heli_Attack_02_dynamicLoadout_F" call _getVehicleName],
            ["_vehicleType", "O_Heli_Attack_02_dynamicLoadout_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", [
                "PylonRack_19Rnd_Rocket_Skyfire",
                "PylonMissile_1Rnd_Bomb_03_F",
                "PylonMissile_1Rnd_Bomb_03_F",
                "PylonRack_19Rnd_Rocket_Skyfire"
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
        ["cas_heli_hellcat_armed", createHashMapFromArray [
            ["_displayName", "WY-55 Hellcat (Armed)"],
            ["_vehicleType", "I_Heli_light_03_dynamicLoadout_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "cas_heli"],
            ["_cost", 10000]
        ]],
        ["cas_heli_littlebird_armed", createHashMapFromArray [
            ["_displayName", "B_Heli_Light_01_dynamicLoadout_F" call _getVehicleName],
            ["_vehicleType", "B_Heli_Light_01_dynamicLoadout_F"],
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
        ["cas_plane_xian_infantry", createHashMapFromArray [
            ["_displayName", "O_T_VTOL_02_infantry_dynamicLoadout_F" call _getVehicleName],
            ["_vehicleType", "O_T_VTOL_02_infantry_dynamicLoadout_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", [
                ["PylonRack_19Rnd_Rocket_Skyfire", false, [-1]],
                ["PylonMissile_1Rnd_Bomb_03_F",    false, [-1]],
                ["PylonMissile_1Rnd_Bomb_03_F",    false, [-1]],
                ["PylonRack_19Rnd_Rocket_Skyfire", false, [-1]]
            ]],
            ["_vehicleRandomDir", false],
            ["_category", "cas_plane"],
            ["_cost", 30000]
        ]],
        ["heli_ghosthawk", createHashMapFromArray [
            ["_displayName", "B_CTRG_Heli_Transport_01_tropic_F" call _getVehicleName],
            ["_vehicleType", "B_CTRG_Heli_Transport_01_tropic_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "heli"],
            ["_cost", 2000]
        ]],
        ["heli_huron", createHashMapFromArray [
            ["_displayName", "B_Heli_Transport_03_F" call _getVehicleName],
            ["_vehicleType", "B_Heli_Transport_03_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "heli"],
            ["_cost", 7000]
        ]],
        ["heli_littlebird", createHashMapFromArray [
            ["_displayName", "B_Heli_Light_01_F" call _getVehicleName],
            ["_vehicleType", "B_Heli_Light_01_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "heli"],
            ["_cost", 2000]
        ]],
        ["medical_pills", createHashMapFromArray [
            ["_displayName", "RyanZombiesAntiVirusTemporary_Item" call _getWeaponName],
            ["_functionName", "SHZ_fnc_buyPills"],
            ["_category", "medical"],
            ["_cost", 150]
        ]],
        ["mrap_hunter_hmg", createHashMapFromArray [
            ["_displayName", "B_T_MRAP_01_hmg_F" call _getVehicleName],
            ["_vehicleType", "B_T_MRAP_01_hmg_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", true],
            ["_category", "mrap"],
            ["_cost", 5000]
        ]],
        ["plane_blackfish_infantry", createHashMapFromArray [
            ["_displayName", "B_T_VTOL_01_infantry_F" call _getVehicleName],
            ["_vehicleType", "B_T_VTOL_01_infantry_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", false],
            ["_category", "plane"],
            ["_cost", 15000]
        ]],
        ["plane_blackfish_vehicle", createHashMapFromArray [
            ["_displayName", "B_T_VTOL_01_vehicle_F" call _getVehicleName],
            ["_vehicleType", "B_T_VTOL_01_vehicle_F"],
            ["_functionName", "SHZ_fnc_buyVehicle"],
            ["_vehicleLock", true],
            ["_vehiclePylons", []],
            ["_vehicleRandomDir", false],
            ["_category", "plane"],
            ["_cost", 15000]
        ]],
        ["recruit_autorifleman", createHashMapFromArray [
            ["_displayName", "B_T_Soldier_AR_F" call _getVehicleName],
            ["_recruitType", "B_T_Soldier_AR_F"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["recruit_engineer", createHashMapFromArray [
            ["_displayName", "B_T_Engineer_F" call _getVehicleName],
            ["_recruitType", "B_T_Engineer_F"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 200]
        ]],
        ["recruit_grenadier", createHashMapFromArray [
            ["_displayName", "B_T_Soldier_GL_F" call _getVehicleName],
            ["_recruitType", "B_T_Soldier_GL_F"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 200]
        ]],
        ["recruit_marksman", createHashMapFromArray [
            ["_displayName", "B_T_soldier_M_F" call _getVehicleName],
            ["_recruitType", "B_T_soldier_M_F"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["recruit_medic", createHashMapFromArray [
            ["_displayName", "B_T_Medic_F" call _getVehicleName],
            ["_recruitType", "B_T_Medic_F"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 200]
        ]],
        ["recruit_rifleman", createHashMapFromArray [
            ["_displayName", "B_T_Soldier_F" call _getVehicleName],
            ["_recruitType", "B_T_Soldier_F"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 100]
        ]],
        ["recruit_recon", createHashMapFromArray [
            ["_displayName", "B_T_Recon_F" call _getVehicleName],
            ["_recruitType", "B_T_Recon_F"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["recruit_sniper", createHashMapFromArray [
            ["_displayName", "B_T_Sniper_F" call _getVehicleName],
            ["_recruitType", "B_T_Sniper_F"],
            ["_functionName", "SHZ_fnc_buyAIRecruit"],
            ["_category", "recruit"],
            ["_cost", 150]
        ]],
        ["tank_slammer", createHashMapFromArray [
            ["_displayName", "B_T_MBT_01_TUSK_F" call _getVehicleName],
            ["_vehicleType", "B_T_MBT_01_TUSK_F"],
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
