/*
Function: SHZ_fnc_buyBlackfoot

Description:
    Buys an AH-99 Blackfoot for a player.
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

private _type = "B_Heli_Attack_01_dynamicLoadout_F";
private _pos = _vehicleSpawn findEmptyPosition [10, 50, _type];
if (_pos isEqualTo []) exitWith {false};
private _vehicle = createVehicle [_type, _pos];
_vehicle setDir random 360;

[_vehicle] call SHZ_fnc_clearPylonLoadout;
{
    _x params ["_magazine", "_turret"];
    _vehicle setPylonLoadout [_forEachIndex + 1, _magazine, false, _turret];
} forEach [
    ["PylonRack_12Rnd_missiles", [-1]],
    ["PylonMissile_1Rnd_AAA_missiles", [0]],
    ["PylonRack_12Rnd_PG_missiles", [0]],
    ["PylonRack_12Rnd_PG_missiles", [0]],
    ["PylonMissile_1Rnd_AAA_missiles", [0]],
    ["PylonRack_12Rnd_missiles", [-1]]
];

true
