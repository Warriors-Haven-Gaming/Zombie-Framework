enableSaving [false, false];
call SHZ_fnc_setPlayableAILoadouts;

SHZ_missionLoopScript = [
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

SHZ_ambientHordeScript = 0 spawn SHZ_fnc_ambientHordeLoop;
SHZ_garbageCollector = 0 spawn SHZ_fnc_garbageCollectorLoop;
[[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize] spawn SHZ_fnc_spawnCarWrecks;

SHZ_saveName = "default";
SHZ_saveScript = scriptNull;
if (["autosave"] call SHZ_fnc_getSaveVariable) then {
    SHZ_saveScript = 0 spawn SHZ_fnc_saveLoop;
};
call SHZ_fnc_initStatsTracking;

call SHZ_fnc_setWeather;

// Why is this needed on dedicated server?
civilian setFriend [blufor, 1];
