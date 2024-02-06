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
            ["_functionName", "SHZ_fnc_buyBradley"],
            ["_category", "apc"],
            ["_cost", 5000]
        ]],
        ["car_quadbike", createHashMapFromArray [
            ["_displayName", "Quadbike"],
            ["_functionName", "SHZ_fnc_buyQuadbike"],
            ["_category", "car"],
            ["_cost", 1000]
        ]],
        ["cas_heli_ah64d", createHashMapFromArray [
            ["_displayName", "RHS_AH64D_wd" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyAH64D"],
            ["_category", "cas_heli"],
            ["_cost", 20000]
        ]],
        ["cas_heli_blackfoot", createHashMapFromArray [
            ["_displayName", "B_Heli_Attack_01_dynamicLoadout_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyBlackfoot"],
            ["_category", "cas_heli"],
            ["_cost", 20000]
        ]],
        ["cas_heli_littlebird_armed", createHashMapFromArray [
            ["_displayName", "RHS_MELB_AH6M" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyAH6MLittlebird"],
            ["_category", "cas_heli"],
            ["_cost", 10000]
        ]],
        ["cas_plane_blackfish_armed", createHashMapFromArray [
            ["_displayName", "B_T_VTOL_01_armed_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyBlackfishArmed"],
            ["_category", "cas_plane"],
            ["_cost", 30000]
        ]],
        ["cas_plane_gryphon", createHashMapFromArray [
            ["_displayName", "I_Plane_Fighter_04_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyGryphon"],
            ["_category", "cas_plane"],
            ["_cost", 25000]
        ]],
        ["heli_chinook", createHashMapFromArray [
            ["_displayName", "RHS_CH_47F_10" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyChinook"],
            ["_category", "heli"],
            ["_cost", 4000]
        ]],
        ["heli_littlebird", createHashMapFromArray [
            ["_displayName", "RHS_MELB_MH6M" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyMH6MLittlebird"],
            ["_category", "heli"],
            ["_cost", 2000]
        ]],
        ["medical_pills", createHashMapFromArray [
            ["_displayName", "RyanZombiesAntiVirusTemporary_Item" call _getWeaponName],
            ["_functionName", "SHZ_fnc_buyPills"],
            ["_category", "medical"],
            ["_cost", 150]
        ]],
        ["mrap_matv", createHashMapFromArray [
            ["_displayName", "Oshkosh M-ATV (CROWS/M2)"],
            ["_functionName", "SHZ_fnc_buyMATV"],
            ["_category", "mrap"],
            ["_cost", 3500]
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
        ["uav_sentinel", createHashMapFromArray [
            ["_displayName", "B_UAV_05_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buySentinel"],
            ["_category", "uav"],
            ["_cost", 10000]
        ]],
        ["ugv_stomper_rcws", createHashMapFromArray [
            ["_displayName", "B_T_UGV_01_rcws_olive_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyStomperRCWS"],
            ["_category", "ugv"],
            ["_cost", 5000]
        ]]
    ];
    localNamespace setVariable ["SHZ_shopkeeper_catalog", _index];
};

if (_itemID isEqualTo "") exitWith {_index};
_index get _itemID
