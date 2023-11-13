/*
Function: SHZ_fnc_showPlayerStats

Description:
    Shows the given player stats.
    Function must be remote executed on client from the server.

Parameters:
    HashMap stats:
        The player's stats.
        See SHZ_fnc_sendPlayerStats for details on the format.

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
    str _missionsCompleted,
    lineBreak
];
