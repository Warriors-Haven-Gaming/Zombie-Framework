/*
Function: SHZ_fnc_hordeSpawnLoop

Description:
	Runs a spawn loop to generate hordes of zombies.
	Function must be ran in scheduled environment.

Parameters:
	Array | Side sides:
		One or more sides that can activate the spawner.
	Array areaArgs:
		The activation area defined as [center, a, b, angle, isRectangle, c?].
		This also defines the center where hordes will spawn.
		See also: https://community.bistudio.com/wiki/inArea
	Number maxAlive:
		The maximum number of alive zombies allowed.
	Number maxSpawned:
		The maximum number of zombies to spawn.
	Array hordeArgs:
		The arguments to pass to SHZ_fnc_hordeSpawn.
		The horde quantity will be capped to avoid exceeding maxAlive/maxSpawned.
		The horde center can be Anything as it will be replaced with
		a randomly generated position based on areaArgs and hordeRadius.
	Array | Number hordeRadius:
		The radius at which hordes will spawn.
		An array can be passed to specify the minimum and maximum radius.
		This does not factor the radius of the horde itself, meaning a
		hordeRadius of 50m and hordeArgs->radius of 10m can result in
		zombies spawning 60m from areaArgs->center.
	Number initialDelay:
		An initial delay after the spawner is activated before spawning hordes.
	Number hordeDelay:
		The delay between hordes spawned.
		This also affects how frequently the activation area is checked,
		so keep this at a reasonable duration.
		There is also a random 1 second delay to avoid performance stutters
		with other spawners that were started at the same time.

Examples:
	(begin example)
		[
			blufor,
			[_yourPos, 50, 50, 0, false],
			20,
			60,
			[5, "walkerCivilians", independent, [0,0,0], 7, 0.5],
			20,
			5,
			4
		] spawn SHZ_fnc_hordeSpawnLoop;
	(end)

Author:
	thegamecracks

*/
params ["_sides", "_areaArgs", "_maxAlive", "_maxSpawned", "_hordeArgs", "_hordeRadius", "_initialDelay", "_hordeDelay"];

if !(_sides isEqualType []) then {_sides = [_sides]};

private _activatedOnce = false;
private _spawned = 0;
private _units = [];

private _isActivated = {
	/* Checks if units from any of the given sides are in the area. */
	private _sideUnits = flatten (_sides apply {units _x});
	_sideUnits findIf {_x inArea _areaArgs} isNotEqualTo -1
};
private _getAliveCount = {
	/* Returns the number of units that are alive.

	To avoid a memory leak and degraded* performance, this function
	will replace the units array once it reaches 1000 units.
	This isn't bulletproof since hordes could be in the process of spawning
	while this is already running which would result in uncounted zombies,
	but we don't really need to worry about this unless the user requests
	for large hordes over a long duration.

	* Very mild performance degredation:
		 100 units: 0.03ms
		1000 units: 0.3ms

	*/
	if (count _units < 1000) then {{alive _x} count _units} else {
		_units = _units select {alive _x};
		count _units
	}
};
private _hordeCallbackCode = {
	params ["_unit", "_units"];
	_units pushBack _unit;
};
private _makeHordeArgs = {
	/* Generates the arguments for a new horde. */
	params ["_aliveCount"];
	private _hordeArgs = +_hordeArgs;
	_hordeArgs params ["_quantity", "", "", "", "", "", ["_callbacks", []]];

	_quantity = _quantity min (_maxSpawned - _spawned) min (_maxAlive - _aliveCount);
	_hordeArgs set [0, _quantity];
	_center = [_areaArgs # 0, _hordeRadius] call SHZ_fnc_randomPos;
	if (_center isEqualTo [0,0]) exitWith {[]};
	_hordeArgs set [3, _center];
	_callbacks = _callbacks + [[_units, _hordeCallbackCode]];
	_hordeArgs set [6, _callbacks];

	_hordeArgs
};

while {true} do {
	sleep (_hordeDelay + random 1);
	if (_spawned >= _maxSpawned) exitWith {};
	if !(call _isActivated) then {continue};
	if !(_activatedOnce) then {_activatedOnce = true; sleep _initialDelay};

	private _aliveCount = call _getAliveCount;
	if (_aliveCount >= _maxAlive) then {continue};

	private _hordeArgs = [_aliveCount] call _makeHordeArgs;
	if (_hordeArgs isEqualTo []) then {continue};

	_hordeArgs params ["_quantity"];
	_hordeArgs spawn SHZ_fnc_hordeSpawn;
	_spawned = _spawned + _quantity;
};
