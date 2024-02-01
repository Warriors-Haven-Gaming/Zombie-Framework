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
    format [
        localize "$STR_SHZ_showPlayerStats_playerMoney",
        _playerMoney call SHZ_fnc_formatMoney
    ],
    lineBreak,
    format [
        localize "$STR_SHZ_showPlayerStats_zombieKills",
        str _zombieKills
    ],
    lineBreak,
    format [
        localize "$STR_SHZ_showPlayerStats_missionsCompleted",
        str _missionsCompleted
    ],
    lineBreak,
    format [
        localize "$STR_SHZ_showPlayerStats_deaths",
        str _playerDeaths
    ],
    lineBreak
];
