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
    Boolean
        True if successful, false otherwise.

Author:
    thegamecracks

*/
if (!isServer) exitWith {false};
params ["_context"];
values _context params keys _context;

if (isNil "_vehicleSpawn") exitWith {false};

private _type = "B_T_UGV_01_rcws_olive_F";
private _pos = _vehicleSpawn findEmptyPosition [10, 50, _type];
if (_pos isEqualTo []) exitWith {false};
private _vehicle = createVehicle [_type, _pos];
createVehicleCrew _vehicle;
_vehicle setDir random 360;

true
