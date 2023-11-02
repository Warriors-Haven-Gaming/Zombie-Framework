/*
Function: SHZ_fnc_randomPos

Description:
	Attempts to find a random position within given area.

Parameters:
	Position2D center:
		The center of the area.
	Array | Number radius:
		The radius of the area.
		An array can be passed to specify the minimum and maximum radius.

Returns:
	Array
		The position candidate in format [x,y,z] or [0,0] if position cannot be found.

Examples:
	(begin example)
		[[0,0,0], 50] call SHZ_fnc_randomPos;
	(end)
	(begin example)
		[[0,0,0], [20,50]] call SHZ_fnc_randomPos;
	(end)

Author:
	thegamecracks

*/
params ["_center", "_radius"];

private _pos = [0,0];
private _randomPosArgs = [];
private _minRadius = 0;
private _maxRadius = 0;
if (_radius isEqualType []) then {
	_minRadius = _radius # 0;
	_maxRadius = _radius # 1;
} else {
	_maxRadius = _radius;
};

_randomPosArgs pushBack [[_center, _maxRadius]];
if (_minRadius > 0) then {
	_randomPosArgs pushBack [[_center, _minRadius]];
};

for "_i" from 1 to 30 do {
	_pos = _randomPosArgs call BIS_fnc_randomPos;
	if (_pos isNotEqualTo [0,0]) exitWith {};
};
if (_pos isEqualTo [0,0]) then {
	private _empty = _center findEmptyPosition [_minRadius, _maxRadius];
	if (_empty isNotEqualTo []) then {_pos = _empty};
};
_pos
