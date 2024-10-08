/*
Function: SHZ_fnc_hordeSpawn

Description:
    Spawns a horde of zombies.

Parameters:
    Number quantity:
        The number of zombies to spawn.
    Array | String types:
        One or more horde types to spawn. Can be any of:
            "fastCivilians"
            "fastSoldiers"
            "mediumCivilians"
            "mediumSoldiers"
            "slowCivilians"
            "slowSoldiers"
            "walkerCivilians"
            "walkerSoldiers"
            "demons"
            "spiders"
            "crawlers"
            "mixed"
            "mixedStanding"
        Unlike SHZ_fnc_hordeType, this function will throw an exception
        if none of the types are valid.
    Side side:
        The side used for the zombie group.
    Position2D center:
        The position where zombies will spawn around.
    Array | Number radius:
        The radius for zombies to spawn around.
        An array can be passed to specify the minimum and maximum radius.
    Number rate:
        (Optional, default 0)
        The delay between each zombie spawned in seconds.
        If function is ran is unscheduled environment, this has no effect.
    Array callbacks:
        (Optional, default [])
        An array of [arguments, callback] arrays to be scheduled for each
        spawned zombie. When the callback is ran, it will be passed an array
        containing the unit and the user-supplied arguments.

Returns:
    Array
        An array of zombies that were spawned. Note that in scheduled environment,
        this function blocks until the horde has finished spawning.

Examples:
    (begin example)
        [20, "fastCivilians", SHZ_zombieSide, [0,0,0], 10, 0.5] spawn SHZ_fnc_hordeSpawn;
    (end)

Author:
    thegamecracks

*/
params ["_quantity", "_types", "_side", "_center", "_radius", ["_rate", 0], ["_callbacks",[]]];

private _group = createGroup _side;
private _unitTypes = _types call SHZ_fnc_hordeType;
if (count _unitTypes < 1) then {throw format ["Invalid horde type(s): %1", _types]};

private _units = [];
for "_i" from 1 to _quantity do {
    private _pos = [_center, _radius] call SHZ_fnc_randomPos;
    if (_pos isEqualTo [0,0]) exitWith {};

    private _unit = _group createUnit [selectRandom _unitTypes, [0,0,0], [], 0, "CAN_COLLIDE"];
    [_unit] joinSilent _group;
    _unit triggerDynamicSimulation false;
    _units pushBack _unit;
    [_unit] remoteExec ["SHZ_fnc_zombieInit"];

    [_unit,_pos] spawn {
        params ["_unit", "_pos"];
        scriptName "SHZ_fnc_hordeSpawn_teleport";
        // Delayed teleportation should hide the zombie A-posing
        sleep 0.1;
        _unit setPosATL _pos;
    };

    {[_unit, _x # 0] spawn _x # 1} forEach _callbacks;

    if (canSuspend) then {sleep _rate};
};

_group spawn {
    scriptName "SHZ_fnc_hordeSpawn_enableDynamicSimulation";
    sleep 1;
    [_this, true] remoteExec ["enableDynamicSimulation"];
};

_group spawn {
    // https://steamcommunity.com/workshop/filedetails/discussion/501966277/1734342793781632134/
    scriptName "SHZ_fnc_hordeSpawn_stuckCheck";
    sleep 1;
    private _lastPos = getPosASL leader _this;
    while {units _this findIf {alive _x} > -1} do {
        sleep (5 + random 6);

        private _leader = leader _this;
        if (!simulationEnabled _leader) then {continue};

        private _currentPos = getPosASL _leader;
        private _distanceSqr = _currentPos vectorDistanceSqr _lastPos;
        _lastPos = _currentPos;

        if (_distanceSqr < 1) then {doStop _leader};
    };
};

_group spawn {
    scriptName "SHZ_fnc_hordeSpawn_forgetTargets";
    while {units _this findIf {alive _x} > -1} do {
        sleep (10 + random 20);

        private _leader = leader _this;
        if (!alive _leader) then {continue};
        if (!simulationEnabled _leader) then {continue};

        private _units = units _this select {alive _x};
        private _targets = _units apply {_x findNearestEnemy _x};
        _targets = _targets select {!isNull _x};
        _targets = _targets arrayIntersect _targets;

        {
            private _target = _x;
            private _canSee = _units findIf {
                [_x, "VIEW"] checkVisibility [eyePos _x, getPosASL _target] > 0.1
            } > -1;

            if (!_canSee) then {_this forgetTarget _target};
        } forEach _targets;
    };
};

_units
