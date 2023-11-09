/*
Function: SHZ_fnc_updateChannelLoop

Description:
    Periodically updates the player's channel access.
    Function must be ran in scheduled environment.

Examples:
    (begin example)
        0 spawn SHZ_fnc_updateChannelLoop;
    (end)

Author:
    thegamecracks

*/
while {true} do {
    sleep 5;
    if (isNull player) then {continue};
    2 enableChannel (leader player isEqualTo player);
};
