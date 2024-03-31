/*
Script: init.sqf

Description:
    Executed globally when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#init.sqf

Author:
    thegamecracks

*/
diag_log text format ["Initializing %1", briefingName];

SHZ_zombieSide = independent;
// Defines the max zombie threshold before loitering hordes don't spawn
// (actual value is calculated in SHZ_fnc_loiterThresholdLoop)
SHZ_loiteringHordeThreshold = 30;
SHZ_loiteringHordeThresholdScript = 0 spawn SHZ_fnc_loiterThresholdLoop;
// The max distance from any player before a zombie can be garbage collected
SHZ_gcZombieDistance = 200;
// The max distance from any player before queued objects can be deleted
SHZ_gcDeletionDistance = 500;
// The max distance from any player before queued objects can be unhidden
SHZ_gcUnhideDistance = 500;

SHZ_gcDeletionQueue = [];
SHZ_gcUnhideQueue = [];

if (!isMultiplayer) then {
    private _units = units player select {!isPlayer _x};
    {
        if (_forEachIndex >= 7) then {deleteVehicle _x; continue};
        _x setVariable ["SHZ_recruitOwnedBy", getPlayerUID player, true];
    } forEach _units;
};

call SHZ_fnc_initZombieLootHandlers;
