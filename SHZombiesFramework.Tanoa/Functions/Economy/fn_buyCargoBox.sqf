/*
Function: SHZ_fnc_buyCargoBox

Description:
    Buys a cargo box for a player.
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

private _cargoType = _item get "_cargoType";
if (isNil "_cargoType") exitWith {false};
if (isNil "_vehicleSpawn") exitWith {false};

private _pos = _vehicleSpawn findEmptyPosition [1, 50, _cargoType];
if (_pos isEqualTo []) exitWith {false};
private _box = createVehicle [_cargoType, _pos];
_box setDir random 360;

[_box, _player, _item get "_cost"] call SHZ_fnc_addVehicleRefund;

true
