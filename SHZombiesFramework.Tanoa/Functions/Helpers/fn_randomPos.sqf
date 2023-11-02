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
if (_radius isEqualType []) then {
	_radius params ["_minRadius", "_maxRadius"];
	_randomPosArgs pushBack [[_center, _maxRadius]];
	_randomPosArgs pushBack [[_center, _minRadius]];
} else {
	_randomPosArgs pushBack [[_center, _radius]];
};

for "_i" from 1 to 30 do {
	_pos = _randomPosArgs call BIS_fnc_randomPos;
	if (_pos isNotEqualTo [0,0]) exitWith {};
};
if (_pos isEqualTo [0,0]) then {
	private _empty = _center findEmptyPosition [0, _radius];
	if (_empty isNotEqualTo []) then {_pos = _empty};
};
_pos
