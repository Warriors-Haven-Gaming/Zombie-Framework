/*
Function: SHZ_fnc_inAreaTeamSafezone

Description:
    Checks if the given objects or positions are in a team safezone.

Parameters:
    Array | Object positions:
        The objects or positions to check.

Returns:
    Array
        An array of positions that are in a team safezone.

Examples:
    (begin example)
        [player] call SHZ_fnc_inAreaTeamSafezone isNotEqualTo [];
    (end)

Author:
    thegamecracks

*/
if !(_this isEqualType []) then {_this = [_this]};
[_this, "SHZ_safezone_team"] call SHZ_fnc_inAreaMarkers
