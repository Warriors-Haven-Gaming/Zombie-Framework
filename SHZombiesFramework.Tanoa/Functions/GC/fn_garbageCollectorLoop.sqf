/*
Function: SHZ_fnc_garbageCollectorLoop

Description:
    Handles garbage collection of objects.

Author:
    thegamecracks

*/
private _zombieTypes = ["RyanZombieCivilian_F", "RyanZombieB_Soldier_base_F"];
private _isZombie = {
    params ["_unit"];
    _zombieTypes findIf {_unit isKindOf _x} isNotEqualTo -1
};
private _processDiscreetQueue = {
    params ["_queue", "_players", "_minDistance", "_callback"];
    private _queueProcessed = [];
    {
        private _objects = _x select {!isNull _x};
        if (count _objects < 1) then {
            _queueProcessed pushBack _forEachIndex;
            continue;
        };

        private _center = _objects # 0;
        private _area = [getPosATL _center, _minDistance, _minDistance, 0, false];
        if ([_players, _area] call SHZ_fnc_anyInArea) then {continue};

        _callback forEach _objects;
        _queueProcessed pushBack _forEachIndex;
    } forEach _queue;
    {_queue deleteAt _x} forEachReversed _queueProcessed;
};

while {true} do {
    sleep (10 + random 10);
    private _players = allPlayers;
    private _remoteControlledUnits = _players apply {remoteControlled _x} select {!isNull _x};

    private _zombies = units SHZ_zombieSide select {
        if (isPlayer _x) exitWith {false};
        if (_x in _remoteControlledUnits) exitWith {false};
        if !([_x] call _isZombie) exitWith {false};
        if (_x getVariable ["noGarbageCollection", false]) exitWith {false};
        true
    };
    {
        private _area = [getPosATL _x, SHZ_gcZombieDistance, SHZ_gcZombieDistance, 0, false, 250];
        private _nearZombies = _zombies inAreaArray _area;
        _zombies = _zombies - _nearZombies;
    } forEach _players + _remoteControlledUnits;
    {deleteVehicle _x} forEach _zombies;

    [SHZ_gcDeletionQueue, _players, SHZ_gcDeletionDistance, {deleteVehicle _x}] call _processDiscreetQueue;
    [SHZ_gcUnhideQueue, _players, SHZ_gcUnhideDistance, {_x hideObjectGlobal false}] call _processDiscreetQueue;
};
