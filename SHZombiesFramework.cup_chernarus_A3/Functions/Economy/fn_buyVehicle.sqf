/*
Function: SHZ_fnc_buyVehicle

Description:
    Buys a vehicle for a player.
    Function must be executed on server.

Parameters:
    HashMap context:
        The context of the purchase.
        See SHZ_fnc_requestToBuyItem for details on the format.

        The item included in the context should define the following keys:
            String _vehicleType:
                The vehicle type to spawn in.
            Boolean _vehicleLock:
                (Optional, default true)
                If true, the vehicle will be locked to the player.
            Array _vehiclePylons:
                (Optional, default [])
                An array of pylons to set on the vehicle.
                Each element can be either a magazine name or a sub-array
                in the format [magazine, forced, turret].
                If this isn't needed, an empty array can be passed.
                See https://community.bistudio.com/wiki/setPylonLoadout for details.
            Boolean _vehicleRandomDir:
                (Optional, default true)
                If true, the vehicle will be spawned in a random direction.
                If the shopkeeper's context does not define _vehicleSpawnDir,
                a random direction will always be used.

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

private _vehicleType = _item getOrDefault ["_vehicleType", ""];
private _vehicleLock = _item getOrDefault ["_vehicleLock", true];
private _vehiclePylons = _item getOrDefault ["_vehiclePylons", []];
private _vehicleRandomDir = _item getOrDefault ["_vehicleRandomDir", true];

if (_vehicleType isEqualTo "") exitWith {false};
if (_vehicleType isEqualType {}) then {_vehicleType = call _vehicleType};

private _minRadius = 10;
private _maxRadius = 50;
private _vehicleSpawnRadius = _context getOrDefault ["_vehicleSpawnRadius", []];
if (_vehicleSpawnRadius isEqualType 0) then {_maxRadius = _vehicleSpawnRadius};
if (_vehicleSpawnRadius isEqualType []) then {
    _vehicleSpawnRadius params [["_min", _minRadius], ["_max", _maxRadius]];
    _minRadius = _min;
    _maxRadius = _max;
};

private _pos = _vehicleSpawn findEmptyPosition [_minRadius, _maxRadius, _vehicleType];
if (_pos isEqualTo []) exitWith {[
    [],
    "SHZ_fnc_showBuyVehicleObstruction"
]};

private _vehicle = createVehicle [_vehicleType, _pos, [], 0, "CAN_COLLIDE"];

if (_vehicleRandomDir || {isNil "_vehicleSpawnDir"}) then {
    _vehicle setDir random 360;
} else {
    _vehicle setDir _vehicleSpawnDir;
};

private _vehicleConfig = configFile >> "CfgVehicles" >> _vehicleType;
private _isUAV = getNumber (_vehicleConfig >> "isUAV") > 0;
if (_isUAV) then {
    createVehicleCrew _vehicle;
};

if (_vehicleLock) then {
    [_vehicle, _player] call SHZ_fnc_lockVehicleToPlayer;
};

if (count _vehiclePylons > 0) then {
    [_vehicle] call SHZ_fnc_clearPylonLoadout;
    {
        _x params ["_magazine", ["_forced", false], ["_turret", []]];
        _vehicle setPylonLoadout [_forEachIndex + 1, _magazine, _forced, _turret];
    } forEach _vehiclePylons;
};

[_vehicle, _player, _item get "_cost", _shopkeeper] call SHZ_fnc_addShopkeeperPurchaseServer;
[_vehicle, _player, _item get "_cost"] call SHZ_fnc_addVehicleRefund;

true
