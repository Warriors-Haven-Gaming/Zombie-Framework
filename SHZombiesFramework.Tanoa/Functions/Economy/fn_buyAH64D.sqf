/*
Function: SHZ_fnc_buyAH64D

Description:
    Buys an AH-64D Apache for a player.
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

private _type = "RHS_AH64D_wd";
private _pos = _vehicleSpawn findEmptyPosition [10, 50, _type];
if (_pos isEqualTo []) exitWith {false};
private _vehicle = createVehicle [_type, _pos];
_vehicle setDir random 360;

[_vehicle, _player, _item get "_cost"] call SHZ_fnc_addVehicleRefund;
[_vehicle, _player] call SHZ_fnc_lockVehicleToPlayer;

[_vehicle] call SHZ_fnc_clearPylonLoadout;
{
    _vehicle setPylonLoadout [_forEachIndex + 1, _x];
} forEach [
    "rhs_mag_ATAS_AH64_2",
    "rhs_mag_M151_19",
    "rhs_mag_M151_19",
    "rhs_mag_M151_19",
    "rhs_mag_M151_19",
    "rhs_mag_ATAS_AH64_2",
    "rhsusf_M130_CMFlare_Chaff_Magazine_x2"
];

true
