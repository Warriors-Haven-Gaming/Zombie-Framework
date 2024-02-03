/*
Function: SHZ_fnc_showVehicleRefund

Description:
    Shows the amount refunded to the player for a vehicle's destruction.
    Function must be remote executed on client from the server.

Parameters:
    Object vehicle:
        The vehicle that was refunded to the player.
    Number money:
        The amount of money refunded.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_vehicle", "_money"];
hint format [
    localize "$STR_SHZ_showVehicleRefund",
    getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"),
    _money call SHZ_fnc_formatMoney
];
