/*
Function: SHZ_fnc_initChannels

Description:
    Initializes custom channels.
    Function must be ran on server.

Examples:
    (begin example)
        0 spawn SHZ_fnc_initChannels;
    (end)

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

SHZ_channelID_aircraft = radioChannelCreate [
    [1, 0.4, 1, 1],
    "Aircraft channel", // TODO: localize
    "%UNIT_VEH_NAME (%UNIT_NAME)",
    []
];
publicVariable "SHZ_channelID_aircraft";
