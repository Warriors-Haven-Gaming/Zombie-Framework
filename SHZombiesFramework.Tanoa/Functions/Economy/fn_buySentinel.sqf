/*
Function: SHZ_fnc_buySentinel

Description:
    Buys a sentinel bomber for a player.
    Function must be executed on server.

Parameters:
    HashMap context:
        The context of the purchase.
        See SHZ_fnc_requestToBuyItem for details on the format.

Returns:
    Boolean
        True if successful, false otherwise.

Author:
    thegamecracks

*/
if (!isServer) exitWith {false};
params ["_context"];
values _context params keys _context;

if (isNil "_vehicleSpawn") exitWith {false};
if (isNil "_vehicleSpawnDir") exitWith {false};

private _type = "B_UAV_05_F";
private _pos = _vehicleSpawn findEmptyPosition [10, 50, _type];
if (_pos isEqualTo []) exitWith {false};
private _vehicle = createVehicle [_type, _pos];
createVehicleCrew _vehicle;
_vehicle setDir _vehicleSpawnDir;

[_vehicle, _player, _item get "_cost"] call SHZ_fnc_addVehicleRefund;

true
