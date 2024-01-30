/*
Function: SHZ_fnc_showPlayerStats

Description:
    Shows the given player stats.
    Function must be remote executed on client from the server.

Parameters:
    Number money:
        The player's available money.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_money"];
hint format [localize "$STR_SHZ_viewMoneyCallback_money", _money];
