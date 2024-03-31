/*
Function: SHZ_fnc_viewMoneyCallback

Description:
    Shows the player's money.

Parameters:
    Number money:
        The player's available money.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_money"];
hint format [
    localize "$STR_SHZ_viewMoneyCallback_money",
    _money call SHZ_fnc_formatMoney
];
