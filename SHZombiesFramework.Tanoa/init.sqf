/*
Script: init.sqf

Description:
    Executed globally when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#init.sqf

Author:
    thegamecracks

*/
diag_log text format ["Initializing %1", briefingName];

if (!isMultiplayer || {!isServer && {!isClass (configFile >> "CfgPatches" >> "cba_xeh")}}) then {
    // In singleplayer and multiplayer clients, this will run before initServer.sqf.
    call compileScript ["XEH_preInit.sqf"];
};

SHZ_zombieSide = independent;

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
