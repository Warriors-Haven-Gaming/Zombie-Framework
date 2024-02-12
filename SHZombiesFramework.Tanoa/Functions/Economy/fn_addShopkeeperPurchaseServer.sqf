/*
Function: SHZ_fnc_addShopkeeperPurchaseServer

Description:
    Allows a player to refund the given vehicle.
    Function must be executed on server.

Parameters:
    Object vehicle:
        The vehicle to be refunded.
    Object player:
        The player that can refund this vehicle.
    Number money:
        The money to refund the player.
    Object shopkeeper:
        The shopkeeper that the vehicle was purchased from.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_vehicle", "_player", "_money", "_shopkeeper"];
_vehicle setVariable ["SHZ_refundShopkeeperPurchase_money", _money];
[_vehicle, _shopkeeper] remoteExec ["SHZ_fnc_addShopkeeperPurchaseClient", _player];
