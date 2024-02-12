/*
Function: SHZ_fnc_showShareMoneyGUIServer

Description:
    Shows a GUI to a player for sharing money with another player.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The player wanting to share money.
    Object target:
        The player to share money to.

Author:
    thegamecracks

*/
params ["_player", "_target"];
if !([_player] call SHZ_fnc_isPlayerRemoteExecuted) exitWith {};

private _uid = getPlayerUID _player;
private _current = ["playerMoney"] call SHZ_fnc_getSaveVariable getOrDefault [_uid, 0];
[_target, _current] remoteExec ["SHZ_fnc_showShareMoneyGUIClient", _player];
