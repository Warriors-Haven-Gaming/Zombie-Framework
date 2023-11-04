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
		if (random 1 >= 0.5) then {continue};
		if (getPos _x select 2 > 10) then {continue};
		if (_x call SHZ_fnc_inAreaSafezone isNotEqualTo []) then {continue};

		private _quantity = 1 + floor random 5;
		private _rate = 0.2 + random 0.3;

		// For moving players, try to spawn hordes in front so they can see them.
		private _vel = velocity _x vectorMultiply [8, 8, 0];
		private _spawnPos = getPosATL _x;
		_spawnPos = _spawnPos vectorAdd _vel;
		_spawnPos set [2, 0];

		if (surfaceIsWater _spawnPos) then {continue};

		[_quantity, "mixed", SHZ_zombieSide, _spawnPos, [20, 50], _rate] spawn SHZ_fnc_hordeSpawnLoitering;
		// TODO: handle automatic zombie deletion
	} forEach units blufor;
};