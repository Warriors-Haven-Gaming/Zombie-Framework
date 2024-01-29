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
        if (_x getVariable ["SHZ_disableAmbientHordes", false]) then {continue};
        if (getPos _x select 2 > 30) then {continue};
        if (_x call SHZ_fnc_inAreaSafezone isNotEqualTo []) then {continue};
        sleep random 0.5;

        private _chance = 0;

        private _vel = velocity _x;
        private _speed = vectorMagnitude _vel;
        _chance = _chance + _speed / 36;

        // This would make more sense if it checked every nearby vehicle,
        // but it might be a bit too performance-heavy to run
        private _vehicle = objectParent _x;
        if (!isNull _vehicle) then {
            if (isEngineOn _vehicle) then {
                _chance = _chance + 0.1;
            };
            if (isLightOn _vehicle) then {
                _chance = _chance + linearConversion [200, 3, getLighting # 1, 0, 0.1, true];
            };
        };

        if (_x isFlashlightOn currentWeapon _x) then {
            _chance = _chance + linearConversion [200, 3, getLighting # 1, 0, 0.1, true];
        };

        private _pos = getPosATL _x;
        private _location = nearestLocation [
            _pos,
            ["NameVillage", "NameCity", "NameCityCapital"],
            1000
        ];
        if (!isNull _location) then {
            private _distance = position _location distance2D _pos;
            _chance = _chance + linearConversion [1000, 50, _distance, 0, 0.4, true];
        };

        _chance = _chance max 0.01;
        if (random 1 >= _chance) then {continue};

        private _quantity = 1 + floor random (_speed / 3 + 3 max 10);
        private _rate = 0.2 + random 0.3;

        // For moving players, try to spawn hordes in front so they can see them.
        private _spawnPos = getPosATL _x;
        _spawnPos = _spawnPos vectorAdd (_vel vectorMultiply [8, 8, 0]);
        _spawnPos set [2, 0];

        if (surfaceIsWater _spawnPos) then {continue};

        private _minRadius = 50 - _speed * 1.5 max 20;
        private _maxRadius = 100 - _speed * 3 max 50;
        [
            _quantity,
            "mixed",
            SHZ_zombieSide,
            _spawnPos,
            [_minRadius, _maxRadius],
            _rate
        ] spawn SHZ_fnc_hordeSpawnLoitering;
    } forEach units blufor;
};
