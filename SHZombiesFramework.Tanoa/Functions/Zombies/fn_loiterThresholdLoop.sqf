/*
Function: SHZ_fnc_loiterThresholdLoop

Description:
    Dynamically adjusts the loitering horde threshold based on player count.
    Function must be ran in scheduled environment.

Examples:
    (begin example)
        0 spawn SHZ_fnc_loiterThresholdLoop;
    (end)

Author:
    thegamecracks

*/
if (!isClass (configFile >> "CfgPatches" >> "cba_settings")) then {
    SHZ_loiteringHordeThreshold_delay = 120;
    SHZ_loiteringHordeThreshold_min = 40;
    SHZ_loiteringHordeThreshold_max = 200;
    SHZ_loiteringHordeThreshold_playerScale = 1;
    SHZ_loiteringHordeThreshold_random = 20;
};

while {true} do {
    SHZ_loiteringHordeThreshold = floor (
        SHZ_loiteringHordeThreshold_max min (
            SHZ_loiteringHordeThreshold_min
            + count allPlayers * SHZ_loiteringHordeThreshold_playerScale
            + random SHZ_loiteringHordeThreshold_random
        )
    );
    sleep SHZ_loiteringHordeThreshold_delay;
};
