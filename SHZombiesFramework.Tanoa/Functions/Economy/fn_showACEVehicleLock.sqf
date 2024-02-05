/*
Function: SHZ_fnc_showACEVehicleLock

Description:
    Shows that a vehicle was locked to the player.
    Function must be remote executed on client from the server.

Parameters:
    Object vehicle:
        The vehicle that was locked to the player.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_vehicle"];
systemChat format [
    localize "$STR_SHZ_showACEVehicleLock",
    getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")
];
