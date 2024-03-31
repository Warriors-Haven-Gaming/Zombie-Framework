/*
Function: SHZ_fnc_showSharedMoneyFrom

Description:
    Shows that the player successfully shared their money.
    Function must be remote executed on client from the server.

Parameters:
    Number money:
        The amount of money that was shared.
    Object to:
        The player that received the money.
    Number current:
        The amount of money the player has afterwards.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_money", "_to", "_current"];
hint format [
    localize "$STR_SHZ_showSharedMoneyFrom",
    _money call SHZ_fnc_formatMoney,
    name _to,
    _current call SHZ_fnc_formatMoney
];
playSoundUI ["a3\3den\data\sound\cfgsound\notificationdefault.wss"];
