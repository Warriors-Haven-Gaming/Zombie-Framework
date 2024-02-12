/*
Function: SHZ_fnc_showShopkeeperPurchaseRefund

Description:
    Shows that the player successfully refunded their purchase.
    Function must be remote executed on client from the server.

Parameters:
    String type:
        The vehicle type that was refunded.
    Number money:
        The amount of money that was refunded to the player.
    Number current:
        The amount of money the player has afterwards.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_type", "_money", "_current"];
hint format [
    localize "$STR_SHZ_showShopkeeperPurchaseRefund",
    getText (configFile >> "CfgVehicles" >> _type >> "displayName"),
    _money call SHZ_fnc_formatMoney,
    _current call SHZ_fnc_formatMoney
];
