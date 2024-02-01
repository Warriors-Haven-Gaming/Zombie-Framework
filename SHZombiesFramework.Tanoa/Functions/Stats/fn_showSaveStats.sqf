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
    format [
        localize "$STR_SHZ_showSaveStats_playerMoney",
        _playerMoney call SHZ_fnc_formatMoney
    ],
    lineBreak,
    format [
        localize "$STR_SHZ_showSaveStats_zombieKills",
        str _zombieKills
    ],
    lineBreak,
    format [
        localize "$STR_SHZ_showSaveStats_missionsCompleted",
        str _allMissionsCompleted
    ],
    lineBreak,
    format [
        localize "$STR_SHZ_showSaveStats_deaths",
        str _playerDeaths
    ],
    lineBreak
];
