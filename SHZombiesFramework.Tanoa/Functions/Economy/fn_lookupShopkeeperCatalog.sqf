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

private _index = createHashMapFromArray [
    ["bradley", createHashMapFromArray [
        ["_displayName", "M2 Bradley"],
        ["_functionName", "SHZ_fnc_buyBradley"],
        ["_cost", 5000]
    ]],
    ["pills", createHashMapFromArray [
        ["_displayName", "Pills"], // TODO: localize
        ["_functionName", "SHZ_fnc_buyPills"],
        ["_cost", 150]
    ]],
    ["quadbike", createHashMapFromArray [
        ["_displayName", "Quadbike"],
        ["_functionName", "SHZ_fnc_buyQuadbike"],
        ["_cost", 1000]
    ]]
];

if (_itemID isEqualTo "") exitWith {_index};
_index get _itemID
