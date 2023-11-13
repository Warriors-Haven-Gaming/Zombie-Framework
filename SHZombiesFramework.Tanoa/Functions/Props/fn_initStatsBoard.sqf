/*
Function: SHZ_fnc_initStatsBoard

Description:
    Initializes the given object as a statistics board.

Parameters:
    Object obj:
        The object to initialize.

Author:
    thegamecracks

*/
params ["_obj"];

_obj addAction [
    "View Personal Stats",
    {
        params ["", "_caller"];
        [_caller] remoteExec ["SHZ_fnc_sendPlayerStats", 2];
    }
];
_obj addAction [
    "View Game Stats",
    {
        params ["", "_caller"];
        [_caller] remoteExec ["SHZ_fnc_sendSaveStats", 2];
    }
];
