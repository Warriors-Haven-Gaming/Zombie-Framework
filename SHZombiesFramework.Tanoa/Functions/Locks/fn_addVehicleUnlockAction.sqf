/*
Function: SHZ_fnc_addVehicleUnlockAction

Description:
    Adds a permanent action to unlock the given vehicle.
    Function must be remote executed on client from the server.

Parameters:
    Object vehicle:
        The vehicle that was locked to the player.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
params ["_vehicle"];
_vehicle addAction [
    localize "$STR_SHZ_addVehicleUnlockAction_title",
    {
        params ["_target"];
        [_target] remoteExec ["SHZ_fnc_unlockVehicle", _target];
    },
    nil,
    6,
    true,
    true,
    "",
    "locked _target > 0"
];
