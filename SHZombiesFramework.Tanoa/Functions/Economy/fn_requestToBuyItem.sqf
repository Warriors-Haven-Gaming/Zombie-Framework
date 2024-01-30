/*
Function: SHZ_fnc_requestToBuyItem

Description:
    Buys the given item for a player.
    Function must be remote executed on server from a client.

Parameters:
    Object shopkeeper:
        The shopkeeper providing the item.
    Object player:
        The player buying the item.
        This must be owned by the same client remote executing this function.
    String itemID:
        The item to buy.
    HashMap context:
        The shopkeeper's context.

Author:
    thegamecracks

*/
params ["_shopkeeper", "_player", "_itemID", "_context"];
if !([_player] call SHZ_fnc_isPlayerRemoteExecuted) exitWith {};
if (_itemID isEqualTo "") exitWith {};

private _item = [_itemID] call SHZ_fnc_lookupShopkeeperCatalog;
if (count _item < 1) exitWith {};

values _item params keys _item;

private _moneyOld = [_player, _cost, _displayName] call SHZ_fnc_checkMoney;
if (isNil "_moneyOld") exitWith {};

_context = +_context;
_context set ["_shopkeeper", _shopkeeper];
_context set ["_player", _player];
_context set ["_item", _item];
_context set ["_itemID", _itemID];
_context set ["_money", _moneyOld];

private _function = missionNamespace getVariable _functionName;
[_context] call _function;

private _moneyNew = [getPlayerUID _player, (-_cost)] call SHZ_fnc_addMoney;
_context set ["_money", _moneyNew];
[_context] remoteExec ["SHZ_fnc_showSuccessfulPurchase", _player];
