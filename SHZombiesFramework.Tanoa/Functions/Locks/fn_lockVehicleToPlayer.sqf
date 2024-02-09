/*
Function: SHZ_fnc_lockVehicleToPlayer

Description:
    Locks a vehicle to a player.

Parameters:
    Object vehicle:
        The vehicle to remove pylons weapons for.
        This must be local to the client calling this function.
    Object player:
        The player that can unlock the vehicle.

Author:
    thegamecracks

*/
params ["_vehicle", "_player"];
if (isNull _vehicle) exitWith {diag_log text format ["%1: Vehicle is null", _fnc_scriptName]};
if (isNull _player) exitWith {diag_log text format ["%1: Player is null", _fnc_scriptName]};

if (isClass (configFile >> "CfgPatches" >> "ace_vehiclelock")) then {
    [_player, _vehicle, true] call ACE_VehicleLock_fnc_addKeyForVehicle;
    _vehicle lock 2;
    [_vehicle] remoteExec ["SHZ_fnc_showACEVehicleLock", _player];
};
