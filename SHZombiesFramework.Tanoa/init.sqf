diag_log text format ["Initializing %1 v%2", briefingName, call SHZ_fnc_version];

SHZ_zombieSide = independent;
// Defines the max zombie threshold before loitering hordes don't spawn
SHZ_loiteringHordeThreshold = 200;
// The max distance from any player before a zombie can be garbage collected
SHZ_gcZombieDistance = 500;

if (!isMultiplayer) then {
    units player select {!isPlayer _x} select [7] apply {deleteVehicle _x};
};
