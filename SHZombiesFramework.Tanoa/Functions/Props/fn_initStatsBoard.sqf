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
        params ["_target", "_caller"];
        if (time < _target getVariable ["SHZ_cooldown", 0]) exitWith {};
        _target setVariable ["SHZ_cooldown", time + 3];
        [_caller] remoteExec ["SHZ_fnc_sendPlayerStats", 2];
    }
];
_obj addAction [
    "View Game Stats",
    {
        params ["_target", "_caller"];
        if (time < _target getVariable ["SHZ_cooldown", 0]) exitWith {};
        _target setVariable ["SHZ_cooldown", time + 3];
        [_caller] remoteExec ["SHZ_fnc_sendSaveStats", 2];
    }
];
