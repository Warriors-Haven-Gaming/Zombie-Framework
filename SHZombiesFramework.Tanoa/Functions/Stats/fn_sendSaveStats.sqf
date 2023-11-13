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

private _allMissionsCompleted = 0;
{
    _allMissionsCompleted = _allMissionsCompleted + _y
} forEach (["allMissionsCompleted"] call SHZ_fnc_getSaveVariable);

private _playerDeaths = 0;
{
    _playerDeaths = _playerDeaths + _y
} forEach (["playerDeaths"] call SHZ_fnc_getSaveVariable);

private _zombieKills = 0;
{
    _zombieKills = _zombieKills + _y
} forEach (["zombieKills"] call SHZ_fnc_getSaveVariable);

private _stats = createHashMapFromArray [
    ["_allMissionsCompleted", _allMissionsCompleted],
    ["_playerDeaths", _playerDeaths],
    ["_zombieKills", _zombieKills]
];

[_stats] remoteExec ["SHZ_fnc_showSaveStats", remoteExecutedOwner];
