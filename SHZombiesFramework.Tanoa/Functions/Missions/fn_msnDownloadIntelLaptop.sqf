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
    localize "$STR_SHZ_downloadIntelLaptop_action",
    {
        params ["_target", "_caller"];
        _target setVariable ["downloadStarted", true, true];
        _caller sideChat localize "$STR_SHZ_downloadIntelLaptop_start";
        [_target] remoteExec ["SHZ_fnc_msnDownloadIntelLaptopTimer"];
    },
    nil,
    6,
    true,
    true,
    "",
    "!(_target getVariable ['downloadStarted',false])"
];
