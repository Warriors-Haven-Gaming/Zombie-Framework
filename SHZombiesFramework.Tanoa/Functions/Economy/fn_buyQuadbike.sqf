/*
Function: SHZ_fnc_buyQuadbike

Description:
    Buys a quadbike for a player.
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

private _type = "B_T_Quadbike_01_F";
private _pos = _vehicleSpawn findEmptyPosition [0, 50, _type];
private _vehicle = createVehicle [_type, _pos];
_vehicle setDir random 360;

true
