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
        ["blackfish_armed", createHashMapFromArray [
            ["_displayName", "B_T_VTOL_01_armed_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyBlackfishArmed"],
            ["_category", "cas_plane"],
            ["_cost", 30000]
        ]],
        ["blackfoot", createHashMapFromArray [
            ["_displayName", "B_Heli_Attack_01_dynamicLoadout_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyBlackfoot"],
            ["_category", "cas_heli"],
            ["_cost", 20000]
        ]],
        ["bradley", createHashMapFromArray [
            ["_displayName", "M2 Bradley"],
            ["_functionName", "SHZ_fnc_buyBradley"],
            ["_category", "apc"],
            ["_cost", 5000]
        ]],
        ["gryphon", createHashMapFromArray [
            ["_displayName", "I_Plane_Fighter_04_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyGryphon"],
            ["_category", "cas_plane"],
            ["_cost", 25000]
        ]],
        ["littlebird_armed", createHashMapFromArray [
            ["_displayName", "RHS_MELB_AH6M" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buyAH6MLittlebird"],
            ["_category", "cas_heli"],
            ["_cost", 10000]
        ]],
        ["matv", createHashMapFromArray [
            ["_displayName", "Oshkosh M-ATV (CROWS/M2)"],
            ["_functionName", "SHZ_fnc_buyMATV"],
            ["_category", "mrap"],
            ["_cost", 3500]
        ]],
        ["pills", createHashMapFromArray [
            ["_displayName", "RyanZombiesAntiVirusTemporary_Item" call _getWeaponName],
            ["_functionName", "SHZ_fnc_buyPills"],
            ["_category", "medical"],
            ["_cost", 150]
        ]],
        ["quadbike", createHashMapFromArray [
            ["_displayName", "Quadbike"],
            ["_functionName", "SHZ_fnc_buyQuadbike"],
            ["_category", "car"],
            ["_cost", 1000]
        ]],
        ["sentinel", createHashMapFromArray [
            ["_displayName", "B_UAV_05_F" call _getVehicleName],
            ["_functionName", "SHZ_fnc_buySentinel"],
            ["_category", "uav"],
            ["_cost", 10000]
        ]],
        ["stomper_rcws", createHashMapFromArray [
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
