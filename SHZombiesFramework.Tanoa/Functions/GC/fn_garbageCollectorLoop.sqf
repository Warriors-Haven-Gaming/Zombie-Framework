/*
Function: SHZ_fnc_garbageCollectorLoop

Description:
    Handles garbage collection of objects.

Author:
    thegamecracks

*/
private _processDiscreetQueue = {
    params ["_queue", "_units", "_callback"];
    private _queueProcessed = [];
    {
        _x params ["_objects", "_minDistance"];
        _objects = _objects select {!isNull _x};
        if (count _objects < 1) then {
            _queueProcessed pushBack _forEachIndex;
            continue;
        };
        _x set [0, _objects];

        private _center = _objects # 0;
        private _area = [getPosATL _center, _minDistance, _minDistance, 0, false];
        if ([_units, _area] call SHZ_fnc_anyInArea) then {continue};

        _callback forEach _objects;
        _queueProcessed pushBack _forEachIndex;
    } forEach _queue;
    {_queue deleteAt _x} forEachReversed _queueProcessed;
};

while {true} do {
    sleep (10 + random 10);

    {
        private _units = units _x;
        if (count _units < 1) then {continue};

        private _recruitsAreAbandoned = {
            if (isNil {_x getVariable "SHZ_recruitOwnedBy"}) exitWith {false};
            if (isPlayer _x) exitWith {false};
            true
        } forEach _units;

        if (_recruitsAreAbandoned) then {
            {deleteVehicle _x} forEach _units;
        };
    } forEach groups blufor;

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
        !isPlayer _x
        && {!(_x in _remoteControlledUnits)
        && {[_x] call SHZ_fnc_isZombie
        && {_x getVariable ["SHZ_disableGC", false] isNotEqualTo true}}}
    };
    {
        private _area = [getPosATL _x, SHZ_gcZombieDistance, SHZ_gcZombieDistance, 0, false, 250];
        private _nearZombies = _zombies inAreaArray _area;
        _zombies = _zombies - _nearZombies;
    } forEach _units;
    {deleteVehicle _x} forEach _zombies;

    private _time = time;
    {
        if (_x getVariable ["SHZ_disableGC", false] isEqualTo true) then {continue};
        private _collectAt = _x getVariable "garbageCollectAt";
        if (isNil "_collectAt") then {
            _x setVariable ["garbageCollectAt", _time + SHZ_gcLootLifetime];
            continue;
        };
        if (_time < _collectAt) then {continue};
        deleteVehicle _x;
    } forEach ("GroundWeaponHolder" allObjects 0);

    [SHZ_gcDeletionQueue, _units, {deleteVehicle _x}] call _processDiscreetQueue;
    [SHZ_gcUnhideQueue, _units, {_x hideObjectGlobal false}] call _processDiscreetQueue;
};
