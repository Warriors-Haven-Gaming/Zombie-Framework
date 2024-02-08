/*
Function: SHZ_fnc_showMoneyMultiplierReset

Description:
    Shows how much money the player earned since their last trip from base.
    Function must be remote executed on client from the server.

Parameters:
    Number moneyEarned:
        The amount of money that the player earned.
    Number multiplier:
        The money multiplier that the player reached.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_moneyEarned", "_multiplier"];
hint parseText format [
    localize "$STR_SHZ_showMoneyMultiplierReset",
    _moneyEarned call SHZ_fnc_formatMoney,
    _multiplier toFixed 1
];
