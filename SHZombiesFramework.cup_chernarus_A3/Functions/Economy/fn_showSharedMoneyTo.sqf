/*
Function: SHZ_fnc_showSharedMoneyTo

Description:
    Shows that the player successfully received money from another player.
    Function must be remote executed on client from the server.

Parameters:
    Number money:
        The amount of money that was shared.
    Object from:
        The player that shared the money.
    Number current:
        The amount of money the player has afterwards.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_money", "_from", "_current"];
hint format [
    localize "$STR_SHZ_showSharedMoneyTo",
    _money call SHZ_fnc_formatMoney,
    name _from,
    _current call SHZ_fnc_formatMoney
];
