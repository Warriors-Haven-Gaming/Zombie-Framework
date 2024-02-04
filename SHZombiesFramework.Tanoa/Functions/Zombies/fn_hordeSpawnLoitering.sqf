/*
Function: SHZ_fnc_hordeSpawnLoitering

Description:
    A proxy for SHZ_fnc_hordeSpawn that conditionally spawns a horde
    if there are few enough zombies around the map.

Returns:
    Array

Examples:
    (begin example)
        [20, "mixed", SHZ_zombieSide, [0,0,0], 10, 0.5] spawn SHZ_fnc_hordeSpawnLoitering;
    (end)

Author:
    thegamecracks

*/
// TODO: figure out how to count zombies about to be spawned
//       (solution should handle SHZ_fnc_hordeSpawn being terminated)
private _totalZombies = count units SHZ_zombieSide;
private _availableZombies = SHZ_loiteringHordeThreshold - _totalZombies;
if (_availableZombies <= 0) exitWith {[]};
_this call SHZ_fnc_hordeSpawn
