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
