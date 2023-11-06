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
    SHZ_loiteringHordeThreshold = 200 min (
        40 + count allPlayers * 3 + floor random 60
    );
    sleep 120;
};
