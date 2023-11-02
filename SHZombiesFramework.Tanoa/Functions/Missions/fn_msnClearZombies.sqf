/*
Function: SHZ_fnc_msnClearZombies

Description:
	Players must clear out zombies from an area.
	Function must be ran in scheduled environment.

Parameters:
	PositionATL center:
		(Optional, default [])
		If specified, the given position is used for the mission instead of
		attempting to find a suitable location.

Author:
	thegamecracks

*/
params [["_center", []]];

if (_center isEqualTo []) then {
	private _options = selectBestPlaces [[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize, "houses", 100, 50];
	{
		_x params ["_pos", "_expr"];
		if (_expr < 0.8) then {continue};
		_pos pushBack 0;
		_center = _pos;
		break;
	} forEach _options;
};
if (_center isEqualTo []) exitWith {};

private _taskID = call SHZ_fnc_randomTaskID;
[blufor, _taskID, "clearZombies", _center, "CREATED", -1, true, "kill"] call BIS_fnc_taskCreate;

private _activationArea = [_center, 100, 100, 0, false, 20];
private _spawnerScript = [
	blufor,
	_activationArea,
	20 + count allPlayers,
	20 + floor (count allPlayers * 1.6),
	[20 + floor (count allPlayers * 0.5), "mixed", independent, [0,0,0], 10, 0.25 + random 0.75],
	100,
	5,
	15
] spawn SHZ_fnc_hordeSpawnLoop;

if (count units opfor < 100) then {
	[20, "mixed", independent, _center, 75, 1] spawn SHZ_fnc_hordeSpawn;
};

while {true} do {
	sleep 10;
	if (scriptDone _spawnerScript && {count (units opfor inAreaArray _activationArea) < 20}) exitWith {
		[_taskID, "SUCCEEDED"] call SHZ_fnc_taskEnd;
	};
};
_spawnerScript spawn {sleep 120; terminate _this};
