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

if (!isClass (configFile >> "CfgPatches" >> "cba_settings")) then {
    SHZ_gcDeletionDistance = 500;
    SHZ_gcUnhideDistance = 500;
    SHZ_gcZombieDistance = 200;
};

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
