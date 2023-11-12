/*
Function: SHZ_fnc_sendPlayerStats

Description:
    Sends player stats to be displayed for a client.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The player to send stats to.
        This must be owned by the same client remote executing this function.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
if (remoteExecutedOwner isEqualTo 0 && {isMultiplayer}) exitWith {};

params ["_player"];
if (!isPlayer _player) exitWith {};
if (owner _player isNotEqualTo remoteExecutedOwner) exitWith {};

private _uid = getPlayerUID _player;
if (_uid isEqualTo "") exitWith {};

private _stats = createHashMapFromArray [
    ["_zombieKills", ["zombieKills"] call SHZ_fnc_getSaveVariable getOrDefault [_uid, 0]]
];

[_stats] remoteExec ["SHZ_fnc_showPlayerStats", remoteExecutedOwner];
