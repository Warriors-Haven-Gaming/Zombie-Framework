/*
Function: SHZ_fnc_hordeSpawnLoop

Description:
    Runs a spawn loop to generate hordes of zombies.
    Function must be ran in scheduled environment.

Parameters:
    Array | Side sides:
        One or more sides that can activate the spawner.
        Units with "SHZ_disableAmbientHordes" set to true will always be ignored.
    Array areaArgs:
        The activation area defined as [center, a, b, angle, isRectangle, c?].
        This also defines the center where hordes will spawn.
        The activation center's Z height has no effect and will always
        be set to 0 metres (AGL).
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
        This is not affected by how long it takes for a single horde to spawn,
        meaning that hordes can spawn concurrently.
        This also affects how frequently the activation area is checked,
        so keep this at a reasonable duration.
        There is also a random 1 second delay to avoid performance stutters
        with other spawners that were started at the same time.
    Number waitAlive:
        (Optional, default 0)
        The maximum number of zombies that can be alive before the spawner
        is completed. Note that the following conditions are also required
        alongside this:
            - maxSpawned has been reached
            - all hordes have finished spawning
        This is useful for allowing the last horde to be despawned if all
        units leave the area, and to return early if there are only a few
        zombies left.
        If set to a negative number, the spawner will simply return after
        the last horde has spawned.

Examples:
    (begin example)
        [
            blufor,
            [_yourPos, 50, 50, 0, false, 20],
            20,
            60,
            [5, "walkerCivilians", SHZ_zombieSide, [0,0,0], 7, 0.5],
            20,
            5,
            4
        ] spawn SHZ_fnc_hordeSpawnLoop;
    (end)

Author:
    thegamecracks

*/
params [
    "_sides",
    "_areaArgs",
    "_maxAlive",
    "_maxSpawned",
    "_hordeArgs",
    "_hordeRadius",
    "_initialDelay",
    "_hordeDelay",
    ["_waitAlive", 0]
];

if !(_sides isEqualType []) then {_sides = [_sides]};

_areaArgs = +_areaArgs;
_areaArgs # 0 set [2, 0];

private _activatedOnce = false;
private _spawned = 0;
private _units = [];

private _isActivated = {
    /* Checks if units from any of the given sides are in the area. */
    private _sideUnits =
        flatten (_sides apply {units _x})
        select {!(_x getVariable ["SHZ_disableAmbientHordes", false])};
    [_sideUnits, _areaArgs] call SHZ_fnc_anyInArea
};
private _getAliveCount = {
    /* Returns the number of units that are alive. */
    [_units, {alive _x}] call SHZ_fnc_shrinkCount
};

// To keep track of deleted units and respawn them, we'll give them an array
// that they can append to.
private _deleted = [];
private _collectDeletedUnits = {
    /* Returns the number of units deleted since this function was last called. */
    private _total = count _deleted;
    _deleted deleteRange [0, _total];
    _total
};

private _hordeScripts = [];
private _activeHordeScripts = {
    /* Returns the number of horde scripts still active. */
    _hordeScripts = _hordeScripts select {!scriptDone _x};
    count _hordeScripts
};

private _hordeCallback = [
    [_units, _deleted],
    {
        params ["_unit", "_args"];
        _args params ["_units", "_deleted"];
        _units pushBack _unit;
        _unit setVariable ["deletedQueue", _deleted];
        _unit addEventHandler ["Deleted", {
            params ["_unit"];
            if (!alive _unit) exitWith {};
            _deleted = _unit getVariable ["deletedQueue", []];
            _deleted pushBack true;
        }];
    }
];
private _makeHordeArgs = {
    /* Generates the arguments for a new horde. */
    params ["_aliveCount"];
    private _hordeArgs = [] + _hordeArgs;
    _hordeArgs params ["_quantity", "", "", "", "", "", ["_callbacks", []]];

    _quantity = _quantity min (_maxSpawned - _spawned) min (_maxAlive - _aliveCount);
    _hordeArgs set [0, _quantity];
    _center = [_areaArgs # 0, _hordeRadius] call SHZ_fnc_randomPos;
    if (_center isEqualTo [0,0]) exitWith {[]};
    _hordeArgs set [3, _center];
    _callbacks = _callbacks + [_hordeCallback];
    _hordeArgs set [6, _callbacks];

    _hordeArgs
};
private _canSpawnerStop = {
    _spawned = _spawned - call _collectDeletedUnits;
    if (_spawned < _maxSpawned) exitWith {false};
    if (_waitAlive >= 0 && {call _getAliveCount > _waitAlive}) exitWith {false};
    if (call _activeHordeScripts > 0) exitWith {false};
    true
};
private _sleepIteration = {
    /* Sleeps for a single iteration, periodically checking if the spawner can stop.

    Returns true if the full duration elapsed, false otherwise.

    */
    private _timeLeft = _hordeDelay + random 1;
    while {_timeLeft > 0} do {
        private _interval = _timeLeft min (2 + random 3);
        sleep _interval;
        if (call _canSpawnerStop) exitWith {false};
        _timeLeft = _timeLeft - _interval;
        true
    }
};

while {true} do {
    if !(call _sleepIteration) exitWith {};
    if !(call _isActivated) then {continue};
    if !(_activatedOnce) then {_activatedOnce = true; sleep _initialDelay};

    private _aliveCount = call _getAliveCount;
    if (_aliveCount >= _maxAlive) then {continue};

    private _hordeArgs = [_aliveCount] call _makeHordeArgs;
    if (_hordeArgs isEqualTo []) then {continue};

    _hordeArgs params ["_quantity"];
    if (_quantity < 1) then {continue};

    private _script = _hordeArgs spawn SHZ_fnc_hordeSpawn;
    _hordeScripts pushBack _script;
    _spawned = _spawned + _quantity;
};
