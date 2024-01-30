/*
Function: SHZ_fnc_msnRescueCivilians

Description:
    Players must rescue civilians from a building.
    Function must be ran in scheduled environment.

Parameters:
    Object | PositionATL building:
        (Optional, default objNull)
        If a building is given, it will be used to house the civilians.
        If a position is given, it will be used to find a suitable building.
        If objNull or an empty array is given, a random building will be used.

Author:
    thegamecracks

*/
params [["_building", objNull]];
scopeName "main";

private _minQuantity = 2;
private _maxQuantity = 6;

private _getSuitableBuilding = {
    params ["_pos"];
    private _building = nearestBuilding _pos;
    if (isNull _building) exitWith {objNull};
    if (count (_building buildingPos -1) < _minQuantity) exitWith {objNull};
    _building
};

if (_building isEqualType [] && {count _building >= 2}) then {
    _building = [_building] call _getSuitableBuilding;
    if (isNull _building) exitWith {breakOut "main"};
};

if (isNull _building || {_building isEqualTo []}) then {
    private _location = selectRandom nearestLocations [
        [worldSize / 2, worldSize / 2],
        ["NameVillage", "NameCity"],
        sqrt 2 / 2 * worldSize
    ];
    private _randomPosArgs = [[[locationPosition _location, size _location + [0, false]]]];
    for "_i" from 1 to 30 do {
        private _pos = _randomPosArgs call BIS_fnc_randomPos;
        _building = [_pos] call _getSuitableBuilding;
        if (!isNull _building) exitWith {};
    };
};

if (isNull _building) exitWith {};

private _buildingPositions = _building buildingPos -1 call BIS_fnc_arrayShuffle;
private _quantity =
    _minQuantity
    + floor random (_maxQuantity - _minQuantity + 1)
    min count _buildingPositions;
if (_quantity < 1) exitWith {};

private _units = [];
private _group = createGroup civilian;
private _unitTypes = [
    "C_man_1",
    "C_Man_casual_1_F",
    "C_Man_casual_2_F",
    "C_Man_casual_3_F",
    "C_man_sport_1_F",
    "C_man_sport_2_F",
    "C_man_sport_3_F",
    "C_Man_casual_4_F",
    "C_Man_casual_5_F",
    "C_Man_casual_6_F",
    "C_man_polo_1_F",
    "C_man_polo_2_F",
    "C_man_polo_3_F",
    "C_man_polo_4_F",
    "C_man_polo_5_F",
    "C_man_polo_6_F",
    "C_Man_ConstructionWorker_01_Black_F",
    "C_Man_ConstructionWorker_01_Blue_F",
    "C_Man_ConstructionWorker_01_Red_F",
    "C_Man_ConstructionWorker_01_Vrana_F",
    "C_Man_Fisherman_01_F",
    "C_man_hunter_1_F",
    "C_Man_Paramedic_01_F",
    "C_scientist_F",
    "C_Man_UtilityWorker_01_F",
    "C_man_w_worker_F"
];
for "_i" from 1 to _quantity do {
    private _unit = _group createUnit [selectRandom _unitTypes, [0,0,0], [], 50, "NONE"];
    _units pushBack _unit;
    [_unit] joinSilent _group;
    _unit triggerDynamicSimulation false;
    _unit setPosATL (_buildingPositions select _i - 1);
};
doStop _units;
_group spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};

{
    private _locality = [0, -2] select isDedicated;
    [_x, _units] remoteExec ["SHZ_fnc_addEscortAction", _locality, _x];
} forEach _units;

private _unitNeedsRescuing = {
    params ["_unit"];
    alive _unit && {!([_unit] call SHZ_fnc_unitIsCaptured)}
};

private _taskID = [blufor, "", "rescueCivilians", [_units # 0, true], "CREATED", -1, true, "help"] call SHZ_fnc_taskCreate;
private _taskDestinationScript = [_taskID, _units, _unitNeedsRescuing] spawn {
    params ["_taskID", "_units", "_unitNeedsRescuing"];
    scriptName "SHZ_fnc_msnRescueCivilians_taskDestinationScript";
    private _target = _units # 0;
    while {true} do {
        sleep 30;
        private _targetIndex = _units findIf {_x call _unitNeedsRescuing};
        if (_targetIndex isEqualTo -1) exitWith {};
        if (_units # _targetIndex isEqualTo _target) then {continue};
        _target = _units # _targetIndex;
        [_taskID, [_target, false]] call BIS_fnc_taskSetDestination;
    };
};

private _participants = [];
private _captureCount = 0;
private _succeeded = false;

while {true} do {
    sleep 10;

    private _nearbyPlayers = allPlayers inAreaArray [_building, 50, 50, 0, false, 50];
    {_participants pushBackUnique _x} forEach _nearbyPlayers;

    {
        if !(_x call _unitNeedsRescuing) then {continue};
        if ([_x] call SHZ_fnc_inAreaPrison isEqualTo []) then {continue};
        [_x, "rescue"] call SHZ_fnc_captureUnit;
        _captureCount = _captureCount + 1;
    } forEach _units;

    if (_units findIf {_x call _unitNeedsRescuing} isEqualTo -1) exitWith {
        _succeeded = _captureCount > 0;
        [_taskID, ["FAILED", "SUCCEEDED"] select _succeeded] spawn SHZ_fnc_taskEnd;
    };
};

if (_succeeded) then {
    [_fnc_scriptName, _participants] call SHZ_fnc_addCompletedMission;
};
[_units] call SHZ_fnc_queueGCDeletion;
terminate _taskDestinationScript;
