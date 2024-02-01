/*
Function: SHZ_fnc_playerMoneyMarkerCallback

Description:
    Shows the player's money on the map.
    Function must be remote executed on client from the server.

Parameters:
    Number money:
        The amount of money the player has.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_money"];

if (markerColor "player_money" isEqualTo "") exitWith {};

private _text = format [
    localize "$STR_SHZ_playerMoneyMarkerCallback",
    _money call SHZ_fnc_formatMoney
];
"player_money" setMarkerTextLocal _text;
