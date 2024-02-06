/*
Function: SHZ_fnc_buyGryphon

Description:
    Buys a gryphon for a player.
    Function must be executed on server.

Parameters:
    HashMap context:
        The context of the purchase.
        See SHZ_fnc_requestToBuyItem for details on the format.

Returns:
    Array | Boolean
        True if successful, false otherwise.
        An array can also be returned containing the parameters
        and function name to be remote executed on the client.

Author:
    thegamecracks

*/
if (!isServer) exitWith {false};
params ["_context"];
values _context params keys _context;

if (isNil "_vehicleSpawn") exitWith {false};
if (isNil "_vehicleSpawnDir") exitWith {false};

private _type = "I_Plane_Fighter_04_F";
private _maxRadius = _context getOrDefault ["_vehicleSpawnRadius", 50];
private _pos = _vehicleSpawn findEmptyPosition [10, _maxRadius, _type];
if (_pos isEqualTo []) exitWith {false};
private _vehicle = createVehicle [_type, _pos];
_vehicle setDir _vehicleSpawnDir;

[_vehicle, _player, _item get "_cost"] call SHZ_fnc_addVehicleRefund;
[_vehicle, _player] call SHZ_fnc_lockVehicleToPlayer;

[_vehicle] call SHZ_fnc_clearPylonLoadout;
{
    _vehicle setPylonLoadout [_forEachIndex + 1, _x];
} forEach [
    "PylonMissile_Missile_BIM9X_x1",
    "PylonMissile_Missile_BIM9X_x1",
    "PylonRack_Missile_AGM_02_x1",
    "PylonRack_Missile_AGM_02_x1",
    "PylonMissile_Bomb_GBU12_x1",
    "PylonMissile_Bomb_GBU12_x1"
];

true
