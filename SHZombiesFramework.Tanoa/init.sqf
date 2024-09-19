/*
Script: init.sqf

Description:
    Executed globally when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#init.sqf

Author:
    thegamecracks

*/
diag_log text format ["Initializing %1", briefingName];

if (!isMultiplayer) then {
    // Will run before initPlayerLocal.sqf and initServer.sqf
    if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
        call compileScript ["XEH_preInit.sqf"];
    };
};

SHZ_zombieSide = independent;

if (!isMultiplayer) then {
    private _units = units player select {!isPlayer _x};
    {
        if (_forEachIndex >= 7) then {deleteVehicle _x; continue};
        _x setVariable ["SHZ_recruitOwnedBy", getPlayerUID player, true];
    } forEach _units;
};

call SHZ_fnc_initZombieLootHandlers;
