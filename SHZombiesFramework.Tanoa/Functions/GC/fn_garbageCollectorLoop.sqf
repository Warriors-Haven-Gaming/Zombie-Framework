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

while {true} do {
    sleep 10;
    private _remoteControlledUnits = allPlayers apply {remoteControlled _x} select {!isNull _x};
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
    } forEach allPlayers + _remoteControlledUnits;
    {deleteVehicle _x} forEach _zombies;
};
