/*
Function: SHZ_fnc_sendSaveStats

Description:
    Sends current save's stats to be displayed for a client.
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

private _sumHashMapValues = {
    params ["_map"];
    private _total = 0;
    {_total = _total + _y} forEach _map;
    _total
};

private _allMissionsCompleted = ["allMissionsCompleted"]
    call SHZ_fnc_getSaveVariable call _sumHashMapValues;

private _playerDeaths = ["playerDeaths"]
    call SHZ_fnc_getSaveVariable call _sumHashMapValues;

private _zombieKills = ["zombieKills"]
    call SHZ_fnc_getSaveVariable call _sumHashMapValues;

private _stats = createHashMapFromArray [
    ["_allMissionsCompleted", _allMissionsCompleted],
    ["_playerDeaths", _playerDeaths],
    ["_zombieKills", _zombieKills]
];

[_stats] remoteExec ["SHZ_fnc_showSaveStats", remoteExecutedOwner];
