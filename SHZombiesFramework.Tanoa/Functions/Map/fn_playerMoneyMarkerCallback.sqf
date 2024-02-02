/*
Function: SHZ_fnc_playerMoneyMarkerCallback

Description:
    Shows the player's money on the map.
    Function must be remote executed on client from the server.

Parameters:
    Number money:
        The amount of money the player has.
    Number multiplier:
        The player's current money multiplier.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_money", "_multiplier"];

if (markerColor "player_money" isEqualTo "") exitWith {};

private _text = format [
    localize "$STR_SHZ_playerMoneyMarkerCallback",
    _money call SHZ_fnc_formatMoney,
    _multiplier toFixed 1
];
"player_money" setMarkerTextLocal _text;
