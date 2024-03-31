/*
Function: SHZ_fnc_addShopkeeperPurchaseClient

Description:
    Records the given vehicle as a purchase made by the player.
    Function must be remote executed on client from the server.

Parameters:
    Object vehicle:
        The vehicle to be refunded.
    Object shopkeeper:
        The shopkeeper that the vehicle was purchased from.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
if (!hasInterface) exitWith {};
params ["_vehicle", "_shopkeeper"];
private _netId = _shopkeeper call BIS_fnc_netId;
private _queue = SHZ_shopkeeperPurchases getOrDefault [_netId, [], true];
_queue pushBack [time, _vehicle];
call SHZ_fnc_refreshShopkeeperPurchases;
