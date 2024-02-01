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
if (_itemID isEqualTo "") exitWith {
    diag_log text format ["%1: No item ID from %2", _fnc_scriptName, name _player];
};

private _item = [_itemID] call SHZ_fnc_lookupShopkeeperCatalog;
if (count _item < 1) exitWith {
    diag_log text format ["%1: Invalid item ID %2 from %3", _fnc_scriptName, _itemID, name _player];
};

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
private _success = [_context] call _function;

if (!isNil "_success" && {_success isEqualTo true}) then {
    private _moneyNew = [getPlayerUID _player, (-_cost)] call SHZ_fnc_addMoney;
    _context set ["_money", _moneyNew];
    [_context] remoteExec ["SHZ_fnc_showSuccessfulPurchase", _player];
} else {
    private _message = "Something went wrong with the purchase.";
    [_message] remoteExec ["hint", _player]; // TODO: proper response
};
