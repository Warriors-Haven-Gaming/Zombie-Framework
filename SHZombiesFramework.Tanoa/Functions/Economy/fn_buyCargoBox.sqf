/*
Function: SHZ_fnc_buyCargoBox

Description:
    Buys a cargo box for a player.
    Function must be executed on server.

Parameters:
    HashMap context:
        The context of the purchase.
        See SHZ_fnc_requestToBuyItem for details on the format.

        The item included in the context should define the following keys:
            String _cargoType:
                The cargo box type to spawn in.

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

private _maxRadius = _context getOrDefault ["_vehicleSpawnRadius", 50];
private _pos = _vehicleSpawn findEmptyPosition [2, _maxRadius, _cargoType];
if (_pos isEqualTo []) exitWith {false};
private _box = createVehicle [_cargoType, _pos];
_box setDir random 360;

[_box, _player, _item get "_cost", _shopkeeper] call SHZ_fnc_addShopkeeperPurchaseServer;
[_box, _player, _item get "_cost"] call SHZ_fnc_addVehicleRefund;

true
