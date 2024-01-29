/*
Function: SHZ_fnc_garbageCollectorLoop

Description:
    Handles garbage collection of objects.

Author:
    thegamecracks

*/
private _processDiscreetQueue = {
    params ["_queue", "_units", "_minDistance", "_callback"];
    private _queueProcessed = [];
    {
        private _objects = _x select {!isNull _x};
        if (count _objects < 1) then {
            _queueProcessed pushBack _forEachIndex;
            continue;
        };

        private _center = _objects # 0;
        private _area = [getPosATL _center, _minDistance, _minDistance, 0, false];
        if ([_units, _area] call SHZ_fnc_anyInArea) then {continue};

        _callback forEach _objects;
        _queueProcessed pushBack _forEachIndex;
    } forEach _queue;
    {_queue deleteAt _x} forEachReversed _queueProcessed;
};
private _lootLifetime = 300;

while {true} do {
    sleep (10 + random 10);
    private _remoteControlledUnits = allPlayers apply {remoteControlled _x} select {!isNull _x};
    private _units = units blufor select {
        isPlayer _x
        || {!(_x getVariable ["SHZ_disableAmbientHordes", false])
        && {[_x] call SHZ_fnc_inAreaSafezone isEqualTo []}}
    };
    _units append allPlayers;
    _units append _remoteControlledUnits;
    _units = _units arrayIntersect _units;

    private _zombies = units SHZ_zombieSide select {
        if (isPlayer _x) exitWith {false};
        if (_x in _remoteControlledUnits) exitWith {false};
        if !([_x] call SHZ_fnc_isZombie) exitWith {false};
        if (_x getVariable ["SHZ_disableGC", false]) exitWith {false};
        true
    };
    {
        private _area = [getPosATL _x, SHZ_gcZombieDistance, SHZ_gcZombieDistance, 0, false, 250];
        private _nearZombies = _zombies inAreaArray _area;
        _zombies = _zombies - _nearZombies;
    } forEach _units;
    {deleteVehicle _x} forEach _zombies;

    private _time = time;
    {
        if (_x getVariable ["SHZ_disableGC", false]) then {continue};
        private _collectAt = _x getVariable "garbageCollectAt";
        if (isNil "_collectAt") then {
            _x setVariable ["garbageCollectAt", _time + _lootLifetime];
            continue;
        };
        if (_time < _collectAt) then {continue};
        deleteVehicle _x;
    } forEach ("GroundWeaponHolder" allObjects 0);

    [SHZ_gcDeletionQueue, _units, SHZ_gcDeletionDistance, {deleteVehicle _x}] call _processDiscreetQueue;
    [SHZ_gcUnhideQueue, _units, SHZ_gcUnhideDistance, {_x hideObjectGlobal false}] call _processDiscreetQueue;
};
