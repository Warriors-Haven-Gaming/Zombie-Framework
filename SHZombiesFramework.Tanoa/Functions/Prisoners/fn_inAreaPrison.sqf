/*
Function: SHZ_fnc_inAreaPrison

Description:
    Checks if the given objects or positions are in a prison.

Parameters:
    Array | Object positions:
        The objects or positions to check.

Returns:
    Array
        An array of positions that are in a safezone.

Examples:
    (begin example)
        [player] call SHZ_fnc_inAreaPrison isNotEqualTo [];
    (end)

Author:
    thegamecracks

*/
if !(_this isEqualType []) then {_this = [_this]};
_this = _this select {isNull objectParent _x && {getPos _x # 2 < 10}};
[_this, "SHZ_prison"] call SHZ_fnc_inAreaMarkers
