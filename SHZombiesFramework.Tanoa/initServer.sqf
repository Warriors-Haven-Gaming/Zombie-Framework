enableSaving [false, false];
call SHZ_fnc_setPlayableAILoadouts;
SHZ_ambientHordeScript = 0 spawn SHZ_fnc_ambientHordeLoop;
SHZ_garbageCollector = 0 spawn SHZ_fnc_garbageCollectorLoop;
[[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize] spawn SHZ_fnc_spawnCarWrecks;

SHZ_saveName = "default";
SHZ_saveScript = 0 spawn SHZ_fnc_saveLoop;
