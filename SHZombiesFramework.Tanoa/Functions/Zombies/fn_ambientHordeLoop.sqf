/*
Function: SHZ_fnc_ambientHordeLoop

Description:
    Randomly spawns zombies around players not in a safezone.
    Function must be ran in scheduled environment.

Author:
    thegamecracks

*/
while {true} do {
    sleep (2 + random 3);
    {
        sleep random 0.5;
        private _vel = velocity _x;
        private _speed = vectorMagnitude _vel;
        if (random 1 >= _speed / 28 max 0.1) then {continue};
        if (getPos _x select 2 > 10) then {continue};
        if (_x call SHZ_fnc_inAreaSafezone isNotEqualTo []) then {continue};

        private _quantity = 1 + floor random 5;
        private _rate = 0.2 + random 0.3;

        // For moving players, try to spawn hordes in front so they can see them.
        private _spawnPos = getPosATL _x;
        _spawnPos = _spawnPos vectorAdd (_vel vectorMultiply [8, 8, 0]);
        _spawnPos set [2, 0];

        if (surfaceIsWater _spawnPos) then {continue};

        [_quantity, "mixed", SHZ_zombieSide, _spawnPos, [20, 50], _rate] spawn SHZ_fnc_hordeSpawnLoitering;
    } forEach units blufor;
};
