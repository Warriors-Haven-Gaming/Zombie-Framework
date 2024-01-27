/*
Function: SHZ_fnc_captureUnit

Description:
    Sets the given unit as captured.

Parameters:
    Object unit:
        The unit to be captured.
    String type:
        The type of capture. Must be one of:
            "prison"
            "rescue"

Examples:
    (begin example)
        [_unit, "prison"] call SHZ_fnc_captureUnit;
    (end)
Author:
    thegamecracks

*/
params ["_unit", "_type"];
[_unit] joinSilent grpNull;
_unit disableAI "all";
_unit setVariable ["SHZ_captured", true, true];
