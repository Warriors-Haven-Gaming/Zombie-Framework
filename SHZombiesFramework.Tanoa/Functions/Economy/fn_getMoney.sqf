/*
Function: SHZ_fnc_getMoney

Description:
    Gets the money available for a player.
    Function must be executed on server.

Parameters:
    String uid:
        The player's UID.

Returns:
    Number
        The amount of money the player has.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
params ["_uid"];
private _playerMoney = ["playerMoney"] call SHZ_fnc_getSaveVariable;
_playerMoney getOrDefault [_uid, 0]
