/*
Script: initServer.sqf

Description:
    Executed only on server when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#initServer.sqf

Author:
    thegamecracks

*/
skipTime random 24;
enableSaving [false, false];
call SHZ_fnc_setPlayableAILoadouts;
call SHZ_fnc_initChannels;

SHZ_globalPlayerTarget = [0, -2] select isDedicated;
publicVariable "SHZ_globalPlayerTarget";

SHZ_mainMissionLoop_script = [
    [
        "SHZ_fnc_msnMainClearZombies"
    ],
    1,
    1
] spawn SHZ_fnc_missionLoop;
SHZ_sideMissionLoop_script = [
    [
        "SHZ_fnc_msnAssistSoldiers",
        "SHZ_fnc_msnClearDemons",
        "SHZ_fnc_msnClearRaiders",
        "SHZ_fnc_msnClearZombies",
        "SHZ_fnc_msnDownloadIntel",
        "SHZ_fnc_msnRescueCivilians"
    ],
    6,
    15
] spawn SHZ_fnc_missionLoop;

SHZ_moneyEarned = createHashMap;
SHZ_moneyMultipliers_rate_normal = 1 / 5000;
SHZ_moneyMultipliers_current = createHashMap;
SHZ_moneyMultipliers_script = 0 spawn SHZ_fnc_moneyMultiplierLoop;
call SHZ_fnc_initMoneyShareActionsServer;

SHZ_vehicleRefund_handlers = [];
SHZ_vehicleRefund_script = 0 spawn SHZ_fnc_vehicleRefundLoop;

SHZ_ambientHorde_script = 0 spawn SHZ_fnc_ambientHordeLoop;
SHZ_garbageCollector_script = 0 spawn SHZ_fnc_garbageCollectorLoop;
SHZ_playerMoneyMarker_script = 0 spawn SHZ_fnc_playerMoneyMarkerLoop;
[[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize] spawn SHZ_fnc_spawnCarWrecks;
[[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize] spawn SHZ_fnc_spawnDamagedVehicles;

SHZ_saveName = "default";
SHZ_saveScript = scriptNull;
if (["autosave"] call SHZ_fnc_getSaveVariable) then {
    SHZ_saveScript = 0 spawn SHZ_fnc_saveLoop;
};
call SHZ_fnc_initStatsTracking;

call SHZ_fnc_setWeather;

// Why is this needed on dedicated server?
civilian setFriend [blufor, 1];
