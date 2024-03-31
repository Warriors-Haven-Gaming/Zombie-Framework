/*
Function: SHZ_fnc_viewMoney

Description:
    Sends the available money to be displayed for a client.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The player to send their available money to.
        This must be owned by the same client remote executing this function.

Author:
    thegamecracks

*/
params ["_player"];
if !([_player] call SHZ_fnc_isPlayerRemoteExecuted) exitWith {};

private _uid = getPlayerUID _player;
private _money = ["playerMoney"] call SHZ_fnc_getSaveVariable getOrDefault [_uid, 0];
[_money] remoteExec ["SHZ_fnc_viewMoneyCallback", remoteExecutedOwner];
