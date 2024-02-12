/*
Function: SHZ_fnc_spawnDamagedVehicles

Description:
    Spawns damaged vehicles in the given area.
    Function must be ran in scheduled environment.

Parameters:
    Position2D center:
        The area center to find roads.
    Number radius:
        The radius from the center to find roads.

Returns:
    Array
        An array of simple objects that were spawned.

Author:
    thegamecracks

*/
params ["_center", "_radius"];

private _vehicleCount = floor (_radius / 500 * (1 + random 1));
private _vehicleTypes = [
    "B_Heli_Light_01_dynamicLoadout_F",
    "B_Heli_Attack_01_dynamicLoadout_F",
    "B_CTRG_Heli_Transport_01_tropic_F",
    "B_Heli_Transport_03_F",
    "B_T_MRAP_01_gmg_F",
    "B_T_MRAP_01_hmg_F",
    "B_T_MBT_01_TUSK_F",
    "B_T_APC_Wheeled_01_cannon_F"
];

private _vehicles = [];
for "_i" from 1 to _vehicleCount * 5 do {
    private _pos = [_center, _radius] call SHZ_fnc_randomPos;
    if (_pos isEqualTo [0,0]) then {continue};

    private _type = selectRandom _vehicleTypes;
    _pos = _pos findEmptyPosition [20, 50, _type];
    if (_pos isEqualTo []) then {continue};

    if ([_pos] call SHZ_fnc_inAreaSafezone isNotEqualTo []) then {continue};

    private _veh = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
    _veh setDamage (0.1 + random 0.2);
    _veh setDir random 360;
    _veh setFuel random 0.05;

    private _selections = getAllHitPointsDamage _veh select 1;
    {_veh setHitIndex [_forEachIndex, random 0.9]} forEach _selections;

    _veh spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
    _vehicles pushBack _veh;
    if (count _vehicles >= _vehicleCount) exitWith {};
};
diag_log text format ["%1 damaged vehicles spawned", count _vehicles];
_vehicles
