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
    localize "$STR_SHZ_showGameStats_zombieKills",
    str _zombieKills,
    lineBreak,
    localize "$STR_SHZ_showGameStats_missionsCompleted",
    str _allMissionsCompleted,
    lineBreak,
    localize "$STR_SHZ_showGameStats_deaths",
    str _playerDeaths,
    lineBreak
];
