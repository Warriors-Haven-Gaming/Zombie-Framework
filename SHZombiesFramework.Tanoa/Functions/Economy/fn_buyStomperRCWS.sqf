/*
Function: SHZ_fnc_buyStomperRCWS

Description:
    Buys a UGV Stomper RCWS for a player.
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

private _type = "B_T_UGV_01_rcws_olive_F";
private _maxRadius = _context getOrDefault ["_vehicleSpawnRadius", 50];
private _pos = _vehicleSpawn findEmptyPosition [10, _maxRadius, _type];
if (_pos isEqualTo []) exitWith {false};
private _vehicle = createVehicle [_type, _pos];
createVehicleCrew _vehicle;
_vehicle setDir random 360;

[_vehicle, _player, _item get "_cost"] call SHZ_fnc_addVehicleRefund;

true
