/*
Function: SHZ_fnc_refundShopkeeperPurchase

Description:
    Refunds the given vehicle.
    Function must be remote executed on server from a client.

Parameters:
    Object vehicle:
        The vehicle being refunded.
    Object player:
        The player refunding the vehicle.

Author:
    thegamecracks

*/
params ["_vehicle", "_player"];
if !([_player] call SHZ_fnc_isPlayerRemoteExecuted) exitWith {};

private _money = _vehicle getVariable "SHZ_refundShopkeeperPurchase_money";
if (isNil "_money") exitWith {};

diag_log text format [
    "%1: Refunding %2 for %3, owned by %4",
    _fnc_scriptName,
    [configOf _vehicle] call BIS_fnc_displayName,
    _money call SHZ_fnc_formatMoney,
    name _player
];

private _type = typeOf _vehicle;
deleteVehicle _vehicle;

private _current = [getPlayerUID _player, _money, ["REFUND"]] call SHZ_fnc_addMoney;
[_type, _money, _current] remoteExec ["SHZ_fnc_showShopkeeperPurchaseRefund", _player];
