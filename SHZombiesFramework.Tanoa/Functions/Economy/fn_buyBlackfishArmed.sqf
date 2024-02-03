/*
Function: SHZ_fnc_buyBlackfishArmed

Description:
    Buys an armed blackfish for a player.
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

private _type = "B_T_VTOL_01_armed_F";
private _pos = _vehicleSpawn findEmptyPosition [10, 50, _type];
if (_pos isEqualTo []) exitWith {false};
private _vehicle = createVehicle [_type, _pos];
_vehicle setDir _vehicleSpawnDir;

[_vehicle, _player, _item get "_cost"] call SHZ_fnc_addVehicleRefund;
[_vehicle, _player] call SHZ_fnc_lockVehicleToPlayer;

true
