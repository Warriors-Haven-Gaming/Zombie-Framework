/*
Function: SHZ_fnc_msnDownloadIntelLaptop

Description:
    Initializes the intel laptop.

Parameters:
    Object laptop:
        The laptop to initialize.

Author:
    thegamecracks

*/
params ["_laptop"];
_laptop addAction [
    "Download Intel",
    {
        params ["_target", "_caller"];
        _target setVariable ["downloadStarted", true, true];
        _caller sideChat "Intel is being downloaded...";
        [_target] remoteExec ["SHZ_fnc_msnDownloadIntelLaptopTimer"];
    },
    nil,
    6,
    true,
    true,
    "",
    "!(_target getVariable ['downloadStarted',false])"
];
