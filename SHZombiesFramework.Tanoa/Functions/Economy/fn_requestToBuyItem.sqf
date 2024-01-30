/*
Function: SHZ_fnc_requestToBuyItem

Description:
    Buys the given item for a player.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The player buying an item.
        This must be owned by the same client remote executing this function.
    String itemID:
        The item to buy.
    HashMap context:
        The shopkeeper's context.

Author:
    thegamecracks

*/
params ["_player", "_itemID", "_context"];
if !([_player] call SHZ_fnc_isPlayerRemoteExecuted) exitWith {};
if (_itemID isEqualTo "") exitWith {};

private _item = [_itemID] call SHZ_fnc_lookupShopkeeperCatalog;
if (count _item < 1) exitWith {};

values _item params keys _item;

private _money = [_player, _cost, _displayName] call SHZ_fnc_checkMoney;
if (isNil "_money") exitWith {};

private _function = missionNamespace getVariable _functionName;
[_player, _context] call _function;

[getPlayerUID _player, (-_cost)] call SHZ_fnc_addMoney;
