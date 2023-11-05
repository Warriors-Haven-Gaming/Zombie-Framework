/*
Function: SHZ_fnc_msnClearZombies

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
        ["NameVillage", "NameCity"],
        sqrt 2 / 2 * worldSize
    ];
    private _pos = [];
    private _randomPosArgs = [[[locationPosition _location, size _location + [0, false]]]];
    for "_i" from 1 to 30 do {
        _pos = _randomPosArgs call BIS_fnc_randomPos;
        if (_pos isNotEqualTo [0,0]) exitWith {};
    };
    if (_pos isEqualTo [0,0]) exitWith {};
    _center = [locationPosition _location, 0, -1, 10, 0, 0.3, 0, [], [_pos,_pos]] call BIS_fnc_findSafePos;
    if (count _center < 3) then {_center pushBack 0};
};
if (surfaceIsWater _center) exitWith {};

private _terrainObjects = nearestTerrainObjects [_center, [], 15, false];
_terrainObjects apply {hideObjectGlobal _x};

// TODO stash building
/*
Grab data:
Mission: SHZombiesFramework
World: Tanoa
Anchor position: [7120.8, 7515.33]
Area size: 65
Using orientation of objects: no
*/
private _raiderCamp = [
    _center,
    random 360,
    [
        ["Land_IRMaskingCover_02_F",[-0.0258789,-0.0556641,-0.00143909],136.383,1,0,[],"","",false,false],
        ["Land_FoodSacks_01_small_brown_F",[1.16699,-0.849609,-0.00143886],286.94,1,0,[],"","",false,false],
        ["Land_PaperBox_01_small_closed_brown_food_F",[1.89893,-0.53125,-0.00143886],63.7962,1,0,[],"","",false,false],
        ["Box_Syndicate_Wps_F",[0.950684,2.83496,-0.00143886],121.318,1,0,[],"","",true,false],
        ["Box_Syndicate_Ammo_F",[2.13135,2.78467,-0.00143886],60.4458,1,0,[],"","",true,false],
        ["Box_Syndicate_Ammo_F",[2.01855,4.0874,-0.00143886],0,1,0,[],"","",true,false],
        ["Land_PaperBox_01_small_closed_brown_food_F",[4.09717,2.14795,-0.00143886],291.604,1,0,[],"","",false,false],
        ["Land_PaperBox_01_small_closed_brown_food_F",[-4.34521,-2.13672,-0.00143886],0,1,0,[],"","",false,false],
        ["Land_FoodSacks_01_small_brown_F",[4.70264,1.92676,-0.00143886],286.94,1,0,[],"","",false,false],
        ["Land_BagFence_01_end_green_F",[-5.49707,3.32227,-0.00143886],315.015,1,0,[],"","",false,false],
        ["Land_BagFence_01_end_green_F",[-3.05908,5.67139,-0.00143886],135.03,1,0,[],"","",false,false],
        ["Land_BagFence_01_end_green_F",[-5.63623,-3.84082,-0.00143886],45.0147,1,0,[],"","",false,false],
        ["Land_BagFence_01_end_green_F",[4.10254,5.52441,-0.00143886],45.03,1,0,[],"","",false,false],
        ["Land_BagFence_01_end_green_F",[-3.51758,-5.94482,-0.00143886],225,1,0,[],"","",false,false],
        ["Land_BagFence_01_end_green_F",[6.05322,-3.6543,-0.00143886],135.038,1,0,[],"","",false,false],
        ["Land_BagFence_01_end_green_F",[3.64648,-6.08301,-0.00143886],315,1,0,[],"","",false,false],
        ["Land_BagFence_01_long_green_F",[-6.8418,1.9126,-0.00143886],135.015,1,0,[],"","",false,false],
        ["Land_BagFence_01_end_green_F",[6.19482,3.51074,-0.00143886],225.042,1,0,[],"","",false,false],
        ["Land_BagFence_01_long_green_F",[-1.80859,6.91309,-0.00143886],135.03,1,0,[],"","",false,false],
        ["Land_BagFence_01_long_green_F",[-6.88477,-2.58838,-0.00143886],45.0147,1,0,[],"","",false,false],
        ["Land_BagFence_01_long_green_F",[2.68896,6.87061,-0.00143886],225.047,1,0,[],"","",false,false],
        ["Land_BagFence_01_long_green_F",[-2.1084,-7.28906,-0.00143886],45,1,0,[],"","",false,false],
        ["Land_BagFence_01_long_green_F",[2.39258,-7.32959,-0.00143886],315,1,0,[],"","",false,false],
        ["Land_BagFence_01_long_green_F",[7.39844,-2.24365,-0.00143886],315.039,1,0,[],"","",false,false],
        ["Land_BagFence_01_long_green_F",[7.44189,2.25439,-0.00143886],225.042,1,0,[],"","",false,false],
        ["Land_BagFence_01_round_green_F",[-8.18799,-0.356934,-0.00143886],90.0147,1,0,[],"","",false,false],
        ["Land_BagFence_01_round_green_F",[0.423828,8.22119,-0.00143886],180.039,1,0,[],"","",false,false],
        ["Land_BagFence_01_round_green_F",[0.162598,-8.63525,-0.00143886],0,1,0,[],"","",false,false],
        ["Land_BagFence_01_round_green_F",[8.74609,0.0239258,-0.00143886],270.039,1,0,[],"","",false,false]
    ]
] call SHZ_fnc_objectsMapper;

private _group = createGroup opfor;
private _quantity = 10 + count allPlayers min 20 + floor random (count allPlayers * 2 min 20);
private _unitTypes = [
    "I_C_Soldier_Para_7_F",
    "I_C_Soldier_Para_2_F",
    "I_C_Soldier_Para_3_F",
    "I_C_Soldier_Para_1_F",
    "I_L_Criminal_SG_F",
    "I_L_Looter_Rifle_F",
    "I_L_Looter_Pistol_F",
    "I_L_Looter_SG_F",
    "I_C_Soldier_Bandit_4_F"
];
for "_i" from 1 to _quantity do {
    private _unit = _group createUnit [selectRandom _unitTypes, _center, [], 50, "NONE"];
    [_unit] joinSilent _group;
    _unit triggerDynamicSimulation false;
};
_group setBehaviourStrong "SAFE";
_group setCombatMode "RED";
[_group, _center] call BIS_fnc_taskDefend;
[_group, true] remoteExec ["enableDynamicSimulation"];

private _taskID = [blufor, "", "clearRaiders", [leader _group, false], "CREATED", -1, true, "rifle"] call SHZ_fnc_taskCreate;
private _taskDestinationScript = [_taskID, _group] spawn {
    params ["_taskID", "_group"];
    while {true} do {
        sleep 30;
        [_taskID, [leader _group, false]] call BIS_fnc_taskSetDestination;
    };
};

while {true} do {
    sleep 10;
    if (units _group findIf {alive _x} isEqualTo -1) exitWith {
        [_taskID, "SUCCEEDED"] call SHZ_fnc_taskEnd;
    };
};
_raiderCamp spawn {sleep 120; _this apply {deleteVehicle _x}}; // TODO: schedule raider camp objects to be deleted
_terrainObjects spawn {sleep 120; _this apply {_x hideObjectGlobal false}}; // TODO: schedule terrain objects to be unhidden
terminate _taskDestinationScript;
