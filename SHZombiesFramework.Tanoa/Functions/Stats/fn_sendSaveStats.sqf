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
params ["_player"];
if !([_player] call SHZ_fnc_isPlayerRemoteExecuted) exitWith {};

private _uid = getPlayerUID _player;

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

private _playerMoney = ["playerMoney"]
    call SHZ_fnc_getSaveVariable call _sumHashMapValues;

private _zombieKills = ["zombieKills"]
    call SHZ_fnc_getSaveVariable call _sumHashMapValues;

private _stats = createHashMapFromArray [
    ["_allMissionsCompleted", _allMissionsCompleted],
    ["_playerDeaths", _playerDeaths],
    ["_playerMoney", _playerMoney],
    ["_zombieKills", _zombieKills]
];

[_stats] remoteExec ["SHZ_fnc_showSaveStats", remoteExecutedOwner];
