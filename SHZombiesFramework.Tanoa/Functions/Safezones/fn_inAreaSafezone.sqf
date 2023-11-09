/*
Function: SHZ_fnc_inAreaSafezone

Description:
    Checks if the given objects or positions are in a safezone.

Parameters:
    Array | Object positions:
        The objects or positions to check.

Returns:
    Array
        An array of positions that are in a safezone.

Examples:
    (begin example)
        [player] call SHZ_fnc_inAreaSafezone isNotEqualTo [];
    (end)

Author:
    thegamecracks

*/
if !(_this isEqualType []) then {_this = [_this]};
[_this, "SHZ_safezone"] call SHZ_fnc_inAreaMarkers
