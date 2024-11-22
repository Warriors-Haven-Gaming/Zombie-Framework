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

    private _vehicle = objectParent player;
    if (_vehicle isKindOf "Air" && {currentPilot _vehicle isEqualTo player}) then {
        SHZ_channelID_aircraft radioChannelAdd [player];
    } else {
        SHZ_channelID_aircraft radioChannelRemove [player];
    };
};
