/*
Function: SHZ_fnc_showSaveStats

Description:
    Shows the current save's stats.
    Function must be remote executed on client from the server.

Parameters:
    HashMap stats:
        The current save's stats.
        See SHZ_fnc_sendSaveStats for details on the format.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};

params ["_stats"];
values _stats params keys _stats;

hint composeText [
    "Zombie kills: ",
    str _zombieKills,
    lineBreak,
    "Missions completed: ",
    str _allMissionsCompleted,
    lineBreak,
    "Player deaths: ",
    str _playerDeaths,
    lineBreak
];
