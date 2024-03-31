/*
Function: SHZ_fnc_nearestRespawnPosition

Description:
    Determines the position of the nearest respawn for the given unit.

Parameters:
    Object unit:
        The unit to check respawn positions for.

Returns:
    Array
        A Position3D or an empty array if no respawns are available.

Author:
    thegamecracks

*/
params ["_unit"];

private _side = side group _unit;
private _positions = _side call BIS_fnc_getRespawnPositions;
_positions append ([_side] call BIS_fnc_getRespawnMarkers);
_positions = _positions apply {call {
    if (_x isEqualType []) exitWith {_x};
    if (_x isEqualType "") exitWith {markerPos _x};
    if (_x isEqualType objNull) exitWith {getPosATL _x};
    if (_x isEqualType locationNull) exitWith {locationPosition _x};
    if (_x isEqualType grpNull) exitWith {getPosATL leader _x};
    -1
}} select {!(_x isEqualType -1)};
if (_positions isEqualTo []) exitWith {[]};
[_positions, _unit] call BIS_fnc_nearestPosition
