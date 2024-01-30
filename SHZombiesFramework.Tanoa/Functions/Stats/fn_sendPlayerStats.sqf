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
params ["_player"];
if !([_player] call SHZ_fnc_isPlayerRemoteExecuted) exitWith {};

private _uid = getPlayerUID _player;

private _lookupPlayerStat = {
    params ["_name", "_default"];
    [_name] call SHZ_fnc_getSaveVariable getOrDefault [_uid, _default]
};

private _stats = createHashMapFromArray [
    ["_missionsCompleted", ["missionsCompleted",0] call _lookupPlayerStat],
    ["_playerDeaths", ["playerDeaths",0] call _lookupPlayerStat],
    ["_playerMoney", ["playerMoney",0] call _lookupPlayerStat],
    ["_zombieKills", ["zombieKills",0] call _lookupPlayerStat]
];

[_stats] remoteExec ["SHZ_fnc_showPlayerStats", remoteExecutedOwner];
