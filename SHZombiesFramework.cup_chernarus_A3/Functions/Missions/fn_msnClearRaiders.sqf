/*
Function: SHZ_fnc_msnClearRaiders

Description:
    Players must clear out raiders from an area.
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
    private _location = selectRandom nearestLocations [
        [worldSize / 2, worldSize / 2],
        ["NameVillage", "NameCity", "NameCityCapital"],
        sqrt 2 / 2 * worldSize
    ];
    private _pos = [0,0];
    private _randomPosArgs = [[[locationPosition _location, size _location + [0, false]]]];
    for "_i" from 1 to 30 do {
        _pos = _randomPosArgs call BIS_fnc_randomPos;
        if (_pos isEqualTo [0,0]) then {continue};
        if (surfaceIsWater _pos) then {continue};
        break;
    };
    if (_pos isEqualTo [0,0]) exitWith {};
    _center = [_pos, 0, -1, 10, 0, 0.3, 0, [], [_pos,_pos]] call BIS_fnc_findSafePos;
    if (count _center < 3) then {_center pushBack 0};
};
if (_center isEqualTo []) exitWith {
    diag_log text format ["%1: No center found", _fnc_scriptName];
};

private _terrainObjects = nearestTerrainObjects [_center, [], 15, false];
_terrainObjects apply {hideObjectGlobal _x};

private _raiderCamp = [
    _center,
    random 360,
    [
        ["Campfire_burning_F",[-0.0205078,-0.0810547,-0.00143886],0,1,0,[],"","",true,false],
        ["Box_Syndicate_Ammo_F",[-1.84424,6.14648,-0.00143886],56.2225,1,0,[],"","",true,false],
        ["Land_TentSolar_01_bluewhite_F",[-0.680664,-7.05176,-0.00143886],204.291,1,0,[],"","",false,false],
        ["Land_TentSolar_01_bluewhite_F",[-7.44629,-0.523438,-0.00143886],259.175,1,0,[],"","",false,false],
        ["Land_Camping_Light_F",[-1.92773,7.11475,-0.00143886],0,1,0,[],"","",true,false],
        ["Land_PaperBox_01_small_closed_brown_food_F",[-2.02637,-7.17285,-0.00143886],63.7962,1,0,[],"","",false,false],
        ["Land_TentSolar_01_sand_F",[7.65967,-1.13086,-0.00143886],90,1,0,[],"","",false,false],
        ["Land_Sleeping_bag_F",[-7.65674,2.31299,-0.00143886],335.604,1,0,[],"","",false,false],
        ["Land_TentSolar_01_redwhite_F",[-0.535645,8.1626,-0.00143886],358.259,1,0,[],"","",false,false],
        ["Land_Camping_Light_F",[8.11182,0.0585938,-0.00143886],0,1,0,[],"","",true,false],
        ["Box_Syndicate_Ammo_F",[-2.95068,-7.68701,-0.00143886],60.4458,1,0,[],"","",true,false],
        ["Box_Syndicate_Wps_F",[-1.87402,8.19189,-0.00143886],102.185,1,0,[],"","",true,false],
        ["Land_FoodSacks_01_small_brown_F",[-2.29883,-8.43848,-0.00143886],286.94,1,0,[],"","",false,false],
        ["Land_Sleeping_bag_F",[1.65479,-8.55664,-0.00143886],135,1,0,[],"","",false,false],
        ["Land_PaperBox_01_small_closed_brown_food_F",[8.83105,0.00634766,-0.00143886],291.604,1,0,[],"","",false,false],
        ["Land_Sleeping_bag_F",[-8.66162,1.83691,-0.00143886],335.604,1,0,[],"","",false,false],
        ["Land_FoodSacks_01_small_brown_F",[9.43652,-0.214844,-0.00143886],286.94,1,0,[],"","",false,false],
        ["Land_Sleeping_bag_F",[0.881836,-9.35596,-0.00143886],135,1,0,[],"","",false,false],
        ["Land_Sleeping_bag_F",[-9.68262,1.38477,-0.00143886],335.604,1,0,[],"","",false,false],
        ["Land_PaperBox_01_small_closed_brown_food_F",[-9.89453,-0.0883789,-0.00143886],26.0582,1,0,[],"","",false,false],
        ["Land_PaperBox_01_small_closed_brown_food_F",[-9.96973,-0.776367,-0.00143886],120.8,1,0,[],"","",false,false],
        ["Land_Sleeping_bag_F",[0.0854492,-10.1387,-0.00143886],135,1,0,[],"","",false,false],
        ["Land_PaperBox_01_small_closed_brown_food_F",[-10.4106,0.651367,-0.00143886],98.5869,1,0,[],"","",false,false],
        ["Land_Camping_Light_F",[-10.6978,-0.139648,-0.00143886],0,1,0,[],"","",true,false],
        ["Land_Camping_Light_F",[-1.00879,-10.769,-0.00143886],0,1,0,[],"","",true,false],
        ["Land_BagFence_01_round_green_F",[-11.1411,1.51221,-0.00143886],110.619,1,0,[],"","",false,false],
        ["Land_BagFence_01_round_green_F",[0.557129,-11.751,-0.00143886],0,1,0,[],"","",false,false]
    ]
] call SHZ_fnc_objectsMapper;

private _participants = [];
private _quantity = 10 + floor random (count allPlayers min 20);
private _group = [_quantity, _center, 50, true] call SHZ_fnc_spawnRaiders;
{
    [_x, _participants] call SHZ_fnc_addParticipantHandler;
} forEach units _group;
[_group, _center] call BIS_fnc_taskDefend;

private _taskID = [blufor, "", "clearRaiders", [leader _group, true], "CREATED", -1, true, "rifle"] call SHZ_fnc_taskCreate;
private _taskDestinationScript = [_taskID, _group] spawn {
    params ["_taskID", "_group"];
    scriptName "SHZ_fnc_msnClearRaiders_taskDestinationScript";
    private _lastLeader = leader _group;
    while {true} do {
        sleep 30;
        private _currentLeader = leader _group;
        if (isNull _currentLeader) exitWith {};
        if (_currentLeader isEqualTo _lastLeader) then {continue};
        [_taskID, [_currentLeader, false]] call BIS_fnc_taskSetDestination;
        _lastLeader = _currentLeader;
    };
};

while {true} do {
    sleep 10;
    if (units _group findIf {alive _x} isEqualTo -1) exitWith {
        [_taskID, "SUCCEEDED"] spawn SHZ_fnc_taskEnd;
    };
};

[_fnc_scriptName, _participants, 500] call SHZ_fnc_addCompletedMission;
[_raiderCamp] call SHZ_fnc_queueGCDeletion;
[_terrainObjects] call SHZ_fnc_queueGCUnhide;
terminate _taskDestinationScript;
