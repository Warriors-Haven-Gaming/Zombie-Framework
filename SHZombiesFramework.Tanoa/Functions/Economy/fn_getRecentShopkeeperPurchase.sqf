/*
Function: SHZ_fnc_getRecentShopkeeperPurchase

Description:
    Returns the most recent, valid purchase from the given shopkeeper,
    or an empty array if not available.
    Function must be executed on client.

Parameters:
    Object shopkeeper:
        The shopkeeper to get the most recent purchase from.

Returns:
    Array

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {[]};
params ["_shopkeeper"];

private _netId = _shopkeeper call BIS_fnc_netId;
private _purchases = SHZ_shopkeeperPurchases get _netId;
if (isNil "_purchases") exitWith {[]};

private _validPurchase = {
    if (_x call SHZ_fnc_isShopkeeperPurchaseValid) exitWith {_x};
} forEachReversed _purchases;

if (isNil "_validPurchase") exitWith {[]};
_validPurchase
