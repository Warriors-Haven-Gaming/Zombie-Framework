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

private _lookupPlayerStat = {
    params ["_name", "_default"];
    [_name] call SHZ_fnc_getSaveVariable getOrDefault [_uid, _default]
};

private _stats = createHashMapFromArray [
    ["_missionsCompleted", ["missionsCompleted",0] call _lookupPlayerStat],
    ["_playerDeaths", ["playerDeaths",0] call _lookupPlayerStat],
    ["_zombieKills", ["zombieKills",0] call _lookupPlayerStat]
];

[_stats] remoteExec ["SHZ_fnc_showPlayerStats", remoteExecutedOwner];
