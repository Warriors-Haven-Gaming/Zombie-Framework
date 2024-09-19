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

_vehicle lock 2;
if (SHZ_vehicleLock_useACE && {isClass (configFile >> "CfgPatches" >> "ace_vehiclelock")}) then {
    [_player, _vehicle, true] call ACE_VehicleLock_fnc_addKeyForVehicle;
    [_vehicle] remoteExec ["SHZ_fnc_showACEVehicleLock", _player];
} else {
    private _uid = getPlayerUID _player;
    private _jipID = (_vehicle call BIS_fnc_netId) + ":vehicleUnlock";
    [_uid, _vehicle] remoteExec ["SHZ_fnc_addVehicleUnlockAction", 0, _jipID];
    _vehicle addEventHandler ["Deleted", {
        params ["_vehicle"];
        private _jipID = (_vehicle call BIS_fnc_netId) + ":vehicleUnlock";
        remoteExec ["", _jipID];
    }];
};
