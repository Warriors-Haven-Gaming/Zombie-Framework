/*
Function: SHZ_fnc_unitIsCaptured

Description:
    Checks if the given unit(s) are captured.

Parameters:
    Array | Object units:
        The units to check. This should not be nested in an array.

Returns:
    Boolean

Examples:
    (begin example)
        [_unit] call SHZ_fnc_unitIsCaptured;
    (end)
    (begin example)
        [_unitA, _unitB] call SHZ_fnc_unitIsCaptured;
    (end)

Author:
    thegamecracks

*/
if !(_this isEqualType []) then {_this = [_this]};
_this findIf {!(_x getVariable ["SHZ_captured", false])} isEqualTo -1
